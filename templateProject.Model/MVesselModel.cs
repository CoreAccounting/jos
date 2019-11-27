using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace templateProject.Model
{
    public partial class MVesselModel
    {

        public int VesselID { get; set; }
        public string NameVessel { get; set; }
        public string VesselComment { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsActive { get; set; }
        public string UserCreated { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public string UserModified { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
        public int TotalRows { get; set; }

    }


}
