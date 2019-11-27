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
    public class PlanningRepository : GenericRepository<MPlanningModel>
    {
        public PlanningRepository(DbContext context)
        {
            Db = context;
        }
        public ResultStatusModel CUD_Planning(MPlanningModel item,string mode, out string ID)
        {
            SqlParameter id_out = new SqlParameter("id_out", 0) { Direction = ParameterDirection.Output };
            SqlParameter[] sqlParams =
            {
                new SqlParameter("PlanID", SqlDbType.Int) { Value = item.PlanID },
               // new SqlParameter("BLDate", string.IsNullOrEmpty(item.BLDate) ? (object)DBNull.Value : item.BLDate),
                //new SqlParameter("MenuID", item.MenuID),
                //new SqlParameter("AllowCreate", item.AllowCreate),
                //new SqlParameter("AllowRead", item.AllowRead),
                //new SqlParameter("AllowUpdate", item.AllowUpdate),
                //new SqlParameter("AllowDelete", item.AllowDelete),
                //new SqlParameter("IsDeleted", item.IsDeleted),
                //new SqlParameter("UserCreated", string.IsNullOrEmpty(item.UserCreated) ? (object)DBNull.Value : item.UserCreated),
                //new SqlParameter("UserModified", string.IsNullOrEmpty(item.UserModified) ? (object) DBNull.Value : item.UserModified),
                //new SqlParameter("DateCreated", item.DateCreated == null ? (object) DBNull.Value : item.DateCreated),
                //new SqlParameter("DateModified", item.DateModified == null ? (object) DBNull.Value : item.DateModified),

                new SqlParameter("Mode", mode),
                id_out
            };

            List<ResultStatusModel> result =
                Db.Database.SqlQuery<ResultStatusModel>(
                                                "exec sp_CUD_MPlanning " +
                                                "@PlanID" +
                                                "@Mode, @id_out output"
                                            , sqlParams).ToList();
            ID = id_out.Value.ToString();
            return result.FirstOrDefault();
        }

        public List<MPlanningModel> Lookup_MPlan(
          // Nullable<int> PlanID,
            string _BLID,
            string _BLDate,
            string _BLQty,
            string _PONo,
            string _PODate,
            string _POQty,
            string _MaterialCode,
            string _MaterialDesc,
            string _Uom,
            string _BatchCode,
            string _PortOfOrigin,
            string _PostOfDischarge,
            string _WageNo,
            Nullable<bool> _IsDeleted,
            int? PageSize,
            int? PageNumber,
            string OrderBy,
            string Sort
            ) 
        {
            SqlParameter[] sqlParams =
            {
                //new SqlParameter("PlanID", PlanID == null ? (object)DBNull.Value : PlanID),
                new SqlParameter("BLID", string.IsNullOrEmpty(_BLID) ? (object)DBNull.Value : _BLID),
                new SqlParameter("BLDate", string.IsNullOrEmpty(_BLDate) ? (object)DBNull.Value : _BLDate),
                new SqlParameter("BLQty", string.IsNullOrEmpty(_BLQty) ? (object)DBNull.Value : _BLQty),
                new SqlParameter("PONo", string.IsNullOrEmpty(_PONo) ? (object)DBNull.Value : _PONo),
                new SqlParameter("PODate", string.IsNullOrEmpty(_PODate) ? (object)DBNull.Value : _PODate),
                new SqlParameter("POQty", string.IsNullOrEmpty(_POQty) ? (object)DBNull.Value : _POQty),
                new SqlParameter("MaterialCode", string.IsNullOrEmpty(_MaterialCode) ? (object)DBNull.Value : _MaterialCode),
                new SqlParameter("MaterialDesc", string.IsNullOrEmpty(_MaterialDesc) ? (object)DBNull.Value : _MaterialDesc),
                new SqlParameter("Uom", string.IsNullOrEmpty(_Uom) ? (object)DBNull.Value : _Uom),
                new SqlParameter("BatchCode", string.IsNullOrEmpty(_BatchCode) ? (object)DBNull.Value : _BatchCode),
                new SqlParameter("PortOfOrigin", string.IsNullOrEmpty(_PortOfOrigin) ? (object)DBNull.Value : _PortOfOrigin),
                new SqlParameter("PostOfDischarge", string.IsNullOrEmpty(_PostOfDischarge) ? (object)DBNull.Value : _PostOfDischarge),
                new SqlParameter("WageNo", string.IsNullOrEmpty(_WageNo) ? (object)DBNull.Value : _WageNo),

                 new SqlParameter("IsDeleted", _IsDeleted == null ? (Object) DBNull.Value : _IsDeleted),
                new SqlParameter("PageSize", PageSize == null ? (Object) DBNull.Value : PageSize),
                new SqlParameter("PageNumber", PageNumber == null ? (Object) DBNull.Value : PageNumber),
                new SqlParameter("OrderBy", OrderBy == null ? (Object) DBNull.Value : OrderBy),
                new SqlParameter("Sort", Sort == null ? (Object) DBNull.Value : Sort)
                
                
            };
            List<MPlanningModel> result = Db.Database.SqlQuery<MPlanningModel>(
                                                "exec sp_Lookup_MPlanning @PlanID,@BLID,@BLDate,@BLQty,@PONo,@PODate" +
                                                ",@POQty,@MaterialCode,@MaterialDesc,@Uom,@BatchCode,@PortOfOrigin,@PostOfDischarge,@WageNo"+
                                                  ", @PageSize, @PageNumber, @OrderBy, @Sort"
                                            , sqlParams).ToList();

            return result;
        }
    }
}
