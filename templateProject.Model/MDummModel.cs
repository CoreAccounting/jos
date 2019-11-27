using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace templateProject.Model
{
    public partial class MDummyModel
    {
        [Display(Name = "ID")]
        public int PlanID { get; set; }
        [Display(Name = "BL ID")]
        public string BLID { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<int> OrderPage { get; set; }
        public string UserCreated { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public string UserModified { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
    }
}
