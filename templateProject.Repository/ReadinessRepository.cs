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
    public class ReadinessRepository : GenericRepository<MReadinnesModel>
    {
        public ReadinessRepository(DbContext context)
        {
            Db = context;
        }
        //public ResultStatusModel CUD_Readiness(MReadinnesModel item, string mode, out string ID)
        //{
        //    SqlParameter id_out = new SqlParameter("id_out", 0) { Direction = ParameterDirection.Output };
        //    SqlParameter[] sqlParams =
        //    {
        //        new SqlParameter("GroupReadinessID", SqlDbType.Int) { Value = item.GroupReadinessID },
        //        new SqlParameter("GroupReadinessName", string.IsNullOrEmpty(item.GroupReadinessName) ? (object)DBNull.Value : item.GroupReadinessName),
        //        new SqlParameter("IsDeleted", item.IsDeleted),
        //        new SqlParameter("UserCreated", string.IsNullOrEmpty(item.UserCreated) ? (object)DBNull.Value : item.UserCreated),
        //        new SqlParameter("UserModified", string.IsNullOrEmpty(item.UserModified) ? (object) DBNull.Value : item.UserModified),
        //        new SqlParameter("DateCreated", item.DateCreated == null ? (object) DBNull.Value : item.DateCreated),
        //        new SqlParameter("DateModified", item.DateModified == null ? (object) DBNull.Value : item.DateModified),
        //        new SqlParameter("Mode", mode),
        //        id_out
        //    };
        //    List<ResultStatusModel> result =
        //        Db.Database.SqlQuery<ResultStatusModel>(
        //                                        "exec sp_CUD_MReadiness " +
        //                                        "@GroupReadinessID, @GroupReadinessName,@IsDeleted" +
        //                                        ", @UserCreated, @UserModified, @DateCreated, @DateModified, @Mode, @id_out output"
        //                                    , sqlParams).ToList();
        //    ID = id_out.Value.ToString();
        //    return result.FirstOrDefault();
        //}

        public List<MReadinnesModel> Lookup_MReadinessPaging(
        Nullable<int> GroupReadinessID,
        string Category,
        string GroupCategory,string Result,string Problem,string Action, Nullable<bool> _IsDeleted
        )
        {
            SqlParameter[] sqlParams =
            {
                new SqlParameter("GroupReadinessID", GroupReadinessID == null ? (object)DBNull.Value : GroupReadinessID),
                new SqlParameter("Category", string.IsNullOrEmpty(Category) ? (object)DBNull.Value : Category),
                new SqlParameter("GroupCategory", string.IsNullOrEmpty(GroupCategory) ? (object)DBNull.Value : GroupCategory),
                new SqlParameter("Result", string.IsNullOrEmpty(Result) ? (object)DBNull.Value : Result),
                new SqlParameter("Problem", string.IsNullOrEmpty(Problem) ? (object)DBNull.Value : Problem),
                new SqlParameter("Action", string.IsNullOrEmpty(Action) ? (object)DBNull.Value : Action),
                new SqlParameter("IsDeleted", _IsDeleted == null ? (Object) DBNull.Value : _IsDeleted)
                //new SqlParameter("Modul", string.IsNullOrEmpty(Modul) ? (object)DBNull.Value : Modul),
                //new SqlParameter("IsMenu", IsMenu == null ? (object)DBNull.Value : IsMenu),
            };
            List<MReadinnesModel> result = Db.Database.SqlQuery<MReadinnesModel>(
                                                "exec sp_Lookup_MReadiness @GroupReadinessID,@Category,@GroupCategory,@Result,@Action,@Problem,@isDeleted"
                                            , sqlParams).ToList();

            return result;
        }

       
    }
}
