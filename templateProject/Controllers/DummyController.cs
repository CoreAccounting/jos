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
    public class DummyController : Controller
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

        [CustomAuthorize(Users = "User", Roles = "read")]
        public ActionResult Index()
        {
            return View();
        }

        [CustomAuthorize(Users = "Dummy", Roles = "create")]
        public ActionResult Manage(int id = 0)
        {
            UserModel data = new UserModel();
            MDummyModel dummy = new MDummyModel();
            List<MGroupUserModel> group = new List<MGroupUserModel>();
            if (id != 0)
            {
               
                data = uow.UserRepository.Lookup_MUser(id, null, null, null, null, false).FirstOrDefault();

                if (dummy == null)
                {
                    dummy = new MDummyModel();
                    dummy.PlanID = -1;
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

            return View(dummy);
        }

        [CustomAuthorize(Users = "Dummy", Roles = "create")]
        [HttpPost]
        public JsonResult Manage(MDummyModel item)
        {
            UserInfoModel userInfo = (UserInfoModel)GeneralFunctions.GetSession(Configs.session);
            ResultStatusModel result = new ResultStatusModel();
            item.UserCreated = userInfo.UserName;
            item.UserModified = userInfo.UserName;

            if (ModelState.IsValid)
            {
                try
                {
                    string id_out = "";
                    if (item.PlanID == 0)
                    {
                        result = uow.DummyRepository.CUD_Dummy(item, "c", out id_out);
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

        [CustomAuthorize(Users = "user", Roles = "delete")]
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
        [CustomAuthorize(Users = "Dummy", Roles = "read")]
        public JsonResult GridRead(DataTableRequest dt)
        {
            //Init Output
            //DataTableModel<List<MUserVM>> data = new DataTableModel<List<MUserVM>>();

            DataTableModel<List<MDummyModel>> data = new DataTableModel<List<MDummyModel>>();

            //Init Get Data
           // List<MUserVM> list = new List<MUserVM>();

            List<MDummyModel> list = new List<MDummyModel>();


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
                    sortBy = "Nik";
                    break;
                case 4:
                    sortBy = "Email";
                    break;
                case 5:
                    sortBy = "GroupUserName";
                    break;
                default:
                    break;
            }

            int pageNo = (int)Math.Floor((double)(dt.Start / dt.Length)) + 1;
           // list = uow.UserRepository.Lookup_MUserWithGroup(null, searchByOfficialName, searchByUsername, null, null, false, dt.Length, pageNo, sortBy, sortDirection);
            list = uow.DummyRepository.Lookup_MDummy(null,null);

            if (list.Any())
            {
                //data.recordsFiltered = list.FirstOrDefault().TotalRows;
                //data.recordsTotal = list.FirstOrDefault().TotalRows;
            }
            else
            {
                data.recordsFiltered = 0;
                data.recordsTotal = 0;
            }
            //Init Optional
            data.draw = dt.Draw;
            data.data = list;

            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}