using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace templateProject.Model
{
    public partial class MPlanningModel
    {
        [Display(Name = "PlanID")]
        public int PlanID { get; set; }
        [Display(Name = "BL ID")]
        public string BLID { get; set; }
        [Display(Name = "BL Date")]
        public string BLDate { get; set; }
        [Display(Name = "BLQty")]
        public string BLQty { get; set; }
        [Display(Name = "PONo")]
        public string PONo { get; set; }
        [Display(Name = "PODate")]
        public string PODate { get; set; }
        [Display(Name = "Official Name")]
        public string POQty { get; set; }
        [Display(Name = "Official Name")]
        public string MaterialCode { get; set; }
        [Display(Name = "Official Name")]
        public string MaterialDesc { get; set; }
        [Display(Name = "Official Name")]
        public string Uom { get; set; }
        [Display(Name = "Official Name")]
        public string BatchCode { get; set; }
        [Display(Name = "Official Name")]
        public string PortOfOrigin { get; set; }
        [Display(Name = "Official Name")]
        public string PostOfDischarge { get; set; }
        [Display(Name = "Official Name")]
        public string WageNo { get; set; }

        public bool IsDeleted { get; set; }
        public Nullable<int> OrderPage { get; set; }
        public string UserCreated { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public string UserModified { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
        public int TotalRows { get; set; }
    }
}
