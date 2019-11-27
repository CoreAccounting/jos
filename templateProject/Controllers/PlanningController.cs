using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using templateProject.Security;
using templateProject.Repository.Common;
using templateProject.Model;
using templateProject.Helper;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace templateProject.Controllers
{
    public class PlanningController : Controller
    {
        #region Uow
        UnitOfWork uow = new UnitOfWork();
        protected override void Dispose(bool disposing)
        {
            uow.Dispose();
            base.Dispose(disposing);
        }
        #endregion

        #region View

        [CustomAuthorize(Users = "Planning", Roles = "read")]
        public ActionResult Index()
        {
            return View();
        }

        [CustomAuthorize(Users = "Planning", Roles = "create")]
        public ActionResult Manage(int id = 0)
        {
            UserModel data = new UserModel();

            List<MGroupUserModel> group = new List<MGroupUserModel>();
            if (id != 0)
            {
                data = uow.UserRepository.Lookup_MUser(id, null, null, null, null, false).FirstOrDefault();

                if (data == null)
                {
                    data = new UserModel();
                    data.UserID = -1;
                }
                else
                {
                    group = uow.GroupUserRepository.LookUp_MGroupUser(null, null, null);
                }
            }
            else
            {
                group = uow.GroupUserRepository.LookUp_MGroupUser(null, null, null);
            }

            ViewData["GroupList"] = group;

            return View(data);
        }

        [CustomAuthorize(Users = "Planning", Roles = "create")]
        [HttpPost]
        public async Task<JsonResult> Manage(UserModel item)
        {
            UserInfoModel userInfo = (UserInfoModel)GeneralFunctions.GetSession(Configs.session);
            ResultStatusModel result = new ResultStatusModel();
            item.UserCreated = userInfo.UserName;
            item.UserModified = userInfo.UserName;

            if (item.UserID == 0 && string.IsNullOrEmpty(item.Password))
            {
                ModelState.AddModelError("Password", "Password wajib diisi!");
            }

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri("http://10.126.20.22/ws_NIKSAP/Service1.asmx/");
                    HttpResponseMessage response = new HttpResponseMessage();
                    response = await client.GetAsync("GetNIKSAP?employee_code=" + item.Nik + "&userparam=sap&passparam=JOYketC0rdA/F4MBzx5BEA==");
                    var data = await response.Content.ReadAsStringAsync();
                    XElement convertXml = XElement.Parse(data);
                    if (string.IsNullOrEmpty(convertXml.Value))
                    {
                        ModelState.AddModelError("Nik", "Nik tidak ditemukan!");
                    }
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("User", ex.Message);
            }

            if (ModelState.IsValid)
            {
                try
                {
                    MUserVM user = new MUserVM();
                    user.UserID = item.UserID;
                    user.Email = item.Email;
                    user.GroupUserID = item.GroupUserID.ToString();
                    user.GroupUserName = item.GroupUserName;
                    user.IsDeleted = false;
                    user.Nik = item.Nik;
                    user.OfficialName = item.OfficialName;
                    user.UserName = item.UserName;
                    if (item.UserID == 0)
                    {
                        user.Password = Helper.Encryption.EncryptRegular(Configs.KeyEncrypt, item.Password);
                    }
                    user.UserCreated = userInfo.UserName;
                    user.UserModified = userInfo.UserName;

                    string id_out = "";
                    if (item.UserID == 0)
                    {
                        result = uow.UserRepository.CUD_User(user, "c", out id_out);
                    }
                    else
                    {
                        result = uow.UserRepository.CUD_User(user, "u", out id_out);
                    }

                    if (!result.issuccess)
                    {
                        ModelState.AddModelError("Failed", result.err_msg);
                    }
                }
                catch (Exception e)
                {
                    ModelState.AddModelError("Failed", e.Message);
                }
            }
            List<string> Error = (from m in ModelState
                                  where m.Value.Errors.Any()
                                  select m.Value.Errors[0].ErrorMessage).ToList();

            return Json(new { Error = Error, data = item }, JsonRequestBehavior.DenyGet);
        }

        [CustomAuthorize(Users = "Planning", Roles = "delete")]
        [HttpPost]
        public JsonResult Delete(int id = 0)
        {
            UserInfoModel userInfo = (UserInfoModel)GeneralFunctions.GetSession(Configs.session);
            MUserVM user = new MUserVM();
            user.UserID = id;
            user.UserCreated = userInfo.UserName;
            user.UserModified = userInfo.UserName;

            ResultStatusModel result = new ResultStatusModel();

            ModelState.Clear();

            try
            {
                string id_out = "";
                result = uow.UserRepository.CUD_User(user, "d", out id_out);
                if (!result.issuccess)
                {
                    ModelState.AddModelError("Failed", result.msg);
                }
            }
            catch (Exception e)
            {
                ModelState.AddModelError("Failed", e.Message);
            }

            List<string> Error = (from m in ModelState
                                  where m.Value.Errors.Any()
                                  select m.Value.Errors[0].ErrorMessage).ToList();

            return Json(new { Error = Error, data = id }, JsonRequestBehavior.DenyGet);
        }

        [CustomAuthorize(Users = "home", Roles = "read")]
        public ActionResult UserProfile()
        {
            return View();
        }

        #endregion View

        #region Grid
        [CustomAuthorize(Users = "Planning", Roles = "read")]
        public JsonResult GridRead(DataTableRequest dt)
        {
            //Init Output
            DataTableModel<List<MUserVM>> data = new DataTableModel<List<MUserVM>>();
            DataTableModel<List<MPlanningModel>> planning = new DataTableModel<List<MPlanningModel>>();
            //Init Get Data
            List<MUserVM> list = new List<MUserVM>();
            List<MPlanningModel> PlanList = new List<MPlanningModel>();

            //Init Search 
            string searchByOfficialName = !string.IsNullOrEmpty(Request.QueryString["searchByOfficialName"]) ? Request.QueryString["searchByOfficialName"] : null;
            string searchByUsername = !string.IsNullOrEmpty(Request.QueryString["searchByUsername"]) ? Request.QueryString["searchByUsername"] : null;

            //Init Sort
            int sortColumn = 0;
            string sortDirection = "";
            string sortBy = "";
            if (Request.QueryString["order[0][column]"] != null)
            {
                sortColumn = int.Parse(Request.QueryString["order[0][column]"]);
            }
            if (Request.QueryString["order[0][dir]"] != null)
            {
                sortDirection = Request.QueryString["order[0][dir]"];
            }

            switch (sortColumn)
            {
                case 1:
                    sortBy = "PlanID";
                    break;
                case 2:
                    sortBy = "BLID";
                    break;
                case 3:
                    sortBy = "BLDate";
                    break;
                case 4:
                    sortBy = "BLQty";
                    break;
                case 5:
                    sortBy = "PONo";
                    break;
                case 6:
                    sortBy = "PODate";
                    break;
                case 7:
                    sortBy = "POQty";
                    break;
                case 8:
                    sortBy = "MaterialCode";
                    break;
                case 9:
                    sortBy = "MaterialDesc";
                    break;
                case 10:
                    sortBy = "Uom";
                    break;
                case 11:
                    sortBy = "BatchCode";
                    break;
                case 12:
                    sortBy = "PortOfOrigin";
                    break;

                case 13:
                    sortBy = "PostOfDischarge";
                    break;
                case 14:
                    sortBy = "WageNo";
                    break;

                default:
                    break;
            }

            int pageNo = (int)Math.Floor((double)(dt.Start / dt.Length)) + 1;
            list = uow.UserRepository.Lookup_MUserWithGroup(null, searchByOfficialName, searchByUsername, null, null, false, dt.Length, pageNo, sortBy, sortDirection);
            PlanList = uow.PlanningRepository.Lookup_MPlan(searchByOfficialName, searchByUsername,null, null, null, null, null, null, null, null, null, null, null,false, dt.Length, pageNo, sortBy, sortDirection);
            if (PlanList.Any())
            {
                planning.recordsFiltered = PlanList.FirstOrDefault().TotalRows;
                planning.recordsTotal = PlanList.FirstOrDefault().TotalRows;
            }
            else
            {
                planning.recordsFiltered = 0;
                planning.recordsTotal = 0;
            }
            //Init Optional
            planning.draw = dt.Draw;
            planning.data = PlanList;

            return Json(planning, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}