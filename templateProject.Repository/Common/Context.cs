using System;
using System.Collections.Generic;
using System.Data.Entity;

namespace templateProject.Repository.Common
{
    public class Context : DbContext
    {
        public Context()
            : base("ADOEntities")
        {

        }

        static Context()
        {
        }

        public static Context Create()
        {
            return new Context();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            //Database.SetInitializer<Context>(null);
            base.OnModelCreating(modelBuilder);
        }
    }
}
