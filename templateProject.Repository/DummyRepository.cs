using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data.Entity;

using templateProject.Repository.Common;
using templateProject.Model;
using System.Data;

namespace templateProject.Repository
{
    public class DummyRepository : GenericRepository<MDummyModel>
    {
        public DummyRepository(DbContext context)
        {
            Db = context;
        }
        public ResultStatusModel CUD_Dummy(MDummyModel item, string mode, out string ID)
        {
            SqlParameter id_out = new SqlParameter("id_out", 0) { Direction = ParameterDirection.Output };
            SqlParameter[] sqlParams =
            {
                new SqlParameter("PlanID", SqlDbType.Int) { Value = item.PlanID },
                new SqlParameter("BLID", string.IsNullOrEmpty(item.BLID) ? (object) DBNull.Value : item.BLID),
                new SqlParameter("IsDeleted", item.IsDeleted),
                new SqlParameter("UserCreated", string.IsNullOrEmpty(item.UserCreated) ? (object)DBNull.Value : item.UserCreated),
                new SqlParameter("UserModified", string.IsNullOrEmpty(item.UserModified) ? (object) DBNull.Value : item.UserModified),
                new SqlParameter("DateCreated", item.DateCreated == null ? (object) DBNull.Value : item.DateCreated),
                new SqlParameter("DateModified", item.DateModified == null ? (object) DBNull.Value : item.DateModified),                
                new SqlParameter("Mode", mode),
                id_out
            };

            List<ResultStatusModel> result =
                Db.Database.SqlQuery<ResultStatusModel>(
                                                "exec sp_CUD_MDummy " +
                                                "@BLID"
                                            , sqlParams).ToList();
            ID = id_out.Value.ToString();
            return result.FirstOrDefault();
        }

        public List<MDummyModel> Lookup_MDummy(
            Nullable<int> PlanID,
            string BLID)
        {
            SqlParameter[] sqlParams =
            {
                new SqlParameter("PlanID", PlanID == null ? (object)DBNull.Value : PlanID),
                new SqlParameter("BLID", string.IsNullOrEmpty(BLID) ? (object)DBNull.Value : BLID )
            };
            List<MDummyModel> result = Db.Database.SqlQuery<MDummyModel>(
                                                "exec sp_Lookup_MDummy @PlanID, @BLID"
                                            , sqlParams).ToList();

            return result;
        }

        public List<MDummyModel> Lookup_Mdummy(
            Nullable<int> DummyID
        )
        {
            SqlParameter[] sqlParams =
            {
                new SqlParameter("DummyID", DummyID == null ? (Object) DBNull.Value : DummyID),
            };
            List<MDummyModel> result = Db.Database.SqlQuery<MDummyModel>(
                                                "exec sp_Lookup_MenuByUserID @UserID "
                                            , sqlParams).ToList();

            return result;
        }

        
    }
}
