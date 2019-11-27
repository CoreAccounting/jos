using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace templateProject.Model
{
    public partial class MReadinnesModel
    {
        public int GroupReadinessID { get; set; }
        [Display(Name = "Category")]
        public string Category {get;set;}
        public string GroupCategory { get; set; }
        [Display(Name = "Result")]
        public string Result { get; set; }
        [Display(Name = "Problem")]
        public string Problem { get; set; }
        [Display(Name = "Action")]
        public string Action {get;set;}

        public bool IsDeleted { get; set; }
        public string UserCreated { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public string UserModified { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
        public int TotalRows { get; set; }
    }

   
}
