using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using templateProject.Repository.Common;
using System.Net.Http;
using templateProject.Model;
using templateProject.Helper;
using templateProject.Security;

namespace templateProject.Controllers
{
    public class OperationController : Controller
    {
        UnitOfWork uow = new UnitOfWork();
        protected override void Dispose(bool disposing)
        {
            uow.Dispose();
            base.Dispose(disposing);
        }

        // GET: Operation
        public ActionResult Index()
        {
            return View();
        }
       // [CustomAuthorize(Users = "Readiness", Roles = "read")]
        public ActionResult ReadinessCheck()
        {
            return View();
        }

        public ActionResult CargoCheck()
        {
            return View();
        }

        public ActionResult Activity()
        {
            return View();
        }

        public ActionResult EquipmentCheck()
        {
            return View();
        }

        public ActionResult IddleTime()
        {
            return View();
        }

        public ActionResult ShiftEnd()
        {
            return View();
        }

        public ActionResult VesselRelease()
        {
            return View();
        }


    }
}