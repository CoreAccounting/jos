using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using templateProject.Security;
using templateProject.Repository.Common;
using templateProject.Model;
using templateProject.Helper;

namespace templateProject.Controllers
{
    public class ReadinessController : Controller
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

        [CustomAuthorize(Users = "Readiness", Roles = "read")]
        public ActionResult Index()
        {
            return View();
        }

        //[CustomAuthorize(Users = "Readiness", Roles = "create")]
        //public ActionResult Manage(int id = 0)
        //{
           
        //    MReadinnesModel Readiness = new MReadinnesModel();
            
        //   List<MReadinnesModel> ReadList = new List<MReadinnesModel>();
          
        //    ReadList = uow.ReadinessRepository.Lookup_MReadiness(null,null,null);

        //    if (id != 0)
        //    {
        //        Readiness = uow.ReadinessRepository.Lookup_MReadiness(id,null,null).FirstOrDefault();

        //        if (Readiness == null)
        //        {
        //            Readiness = new MReadinnesModel();
        //            Readiness.GroupReadinessID = -1;
        //        }
        //    }
        //    ViewData["ReadinesList"] = Readiness;
        //    return View(Readiness);
        //}

        //[CustomAuthorize(Users = "accessmenu", Roles = "create")]
        //[HttpPost]
        //public JsonResult Manage(MReadinnesModel item)
        //{
        //    UserInfoModel userInfo = (UserInfoModel)GeneralFunctions.GetSession(Configs.session);
        //    ResultStatusModel result = new ResultStatusModel();
        //    item.UserCreated = userInfo.UserName;
        //    item.UserModified = userInfo.UserName;

        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            string id_out = "";
        //            if (item.GroupReadinessID == 0)
        //            {
        //                result = uow.ReadinessRepository.CUD_Readiness(item, "c", out id_out);
        //            }
        //            else
        //            {
        //               // result = uow.GroupUserMenuRepository.CUD_GroupUserMenu(item, "u", out id_out);
        //            }

        //            if (!result.issuccess)
        //            {
        //                ModelState.AddModelError("Failed", result.err_msg);
        //            }
        //        }
        //        catch (Exception e)
        //        {
        //            ModelState.AddModelError("Failed", e.Message);
        //        }
        //    }
        //    List<string> Error = (from m in ModelState
        //                          where m.Value.Errors.Any()
        //                          select m.Value.Errors[0].ErrorMessage).ToList();

        //    return Json(new { Error = Error, data = item }, JsonRequestBehavior.DenyGet);
        //}

        [CustomAuthorize(Users = "accessmenu", Roles = "delete")]
        [HttpPost]
        public JsonResult Delete(int id = 0)
        {
            UserInfoModel userInfo = (UserInfoModel)GeneralFunctions.GetSession(Configs.session);
            MGroupUserMenuModel item = new MGroupUserMenuModel();
            item.GroupUserMenuID = id;
            item.UserCreated = userInfo.UserName;
            item.UserModified = userInfo.UserName;

            ResultStatusModel result = new ResultStatusModel();

            ModelState.Clear();

            try
            {
                string id_out = "";
                result = uow.GroupUserMenuRepository.CUD_GroupUserMenu(item, "d", out id_out);
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

        #endregion View

        #region Grid
        [CustomAuthorize(Users = "Readiness", Roles = "read")]
        public JsonResult GridRead(DataTableRequest dt)
        {
            //Init Output
            DataTableModel<List<MGroupUserMenuModel>> data = new DataTableModel<List<MGroupUserMenuModel>>();
            DataTableModel<List<MReadinnesModel>> ReadData = new DataTableModel<List<MReadinnesModel>>();
            //Init Get Data
            List<MGroupUserMenuModel> list = new List<MGroupUserMenuModel>();
            List<MReadinnesModel> ListRead = new List<MReadinnesModel>();

            //Init Search 
            string searchByReadiness = !string.IsNullOrEmpty(Request.QueryString["searchByReadiness"]) ? Request.QueryString["searchByReadiness"] : null;
            string searchByMenuName = !string.IsNullOrEmpty(Request.QueryString["searchByMenuName"]) ? Request.QueryString["searchByMenuName"] : null;

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
                    sortBy = "GroupReadinessID";
                    break;
                case 2:
                    sortBy = "Category";
                    break;
                case 3:
                    sortBy = "GroupCategory";
                    break;
                case 4:
                    sortBy = "Result";
                    break;
                case 5:
                    sortBy = "Problem";
                    break;
                case 6:
                    sortBy = "Action";
                    break;

                default:
                    break;
            }

            int pageNo = (int)Math.Floor((double)(dt.Start / dt.Length)) + 1;
            //list = uow.GroupUserMenuRepository.Lookup_MGroupUserMenuPaging(null, null, searchByGroupUserName, null, searchByMenuName, dt.Length, pageNo, sortBy, sortDirection);
            ListRead = uow.ReadinessRepository.Lookup_MReadinessPaging(null,null,null,null,null,null,null);
            if (list.Any())
            {
                ReadData.recordsFiltered = ListRead.FirstOrDefault().TotalRows;
                ReadData.recordsTotal = ListRead.FirstOrDefault().TotalRows;
            }
            else
            {
                ReadData.recordsFiltered = 0;
                ReadData.recordsTotal = 0;
            }
            //Init Optional
            ReadData.draw = dt.Draw;
            ReadData.data = ListRead;

            return Json(ReadData, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}