public class ExternalDataService {
    public class RetrieveTableDetails_element {
        public String objectName;
        private String[] objectName_type_info = new String[]{'objectName','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'objectName'};
    }
    public class RetrieveTableDetailsResponse_element {
        public ExternalDataService.ExternalDataResult RetrieveTableDetailsResult;
        private String[] RetrieveTableDetailsResult_type_info = new String[]{'RetrieveTableDetailsResult','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'RetrieveTableDetailsResult'};
    }
    public class RetrieveTableDataResponse_element {
        public ExternalDataService.ExternalDataResult RetrieveTableDataResult;
        private String[] RetrieveTableDataResult_type_info = new String[]{'RetrieveTableDataResult','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'RetrieveTableDataResult'};
    }
    public class RetrieveTableChildrenResponse_element {
        public ExternalDataService.ExternalDataResult RetrieveTableChildrenResult;
        private String[] RetrieveTableChildrenResult_type_info = new String[]{'RetrieveTableChildrenResult','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'RetrieveTableChildrenResult'};
    }
    public class RetrieveTables_element {
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class RetrieveTableData_element {
        public String query;
        private String[] query_type_info = new String[]{'query','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'query'};
    }
    public class ExternalDataResult {
        public Boolean IsSuccessful;
        public String Tables;
        public String Data;
        public String Fields;
        public String InfoSchema;
        public String ForeignKeys;
        private String[] IsSuccessful_type_info = new String[]{'IsSuccessful','Loop',null,'1','1','false'};
        private String[] Tables_type_info = new String[]{'Tables','Loop',null,'0','1','false'};
        private String[] Data_type_info = new String[]{'Data','Loop',null,'0','1','false'};
        private String[] Fields_type_info = new String[]{'Fields','Loop',null,'0','1','false'};
        private String[] InfoSchema_type_info = new String[]{'InfoSchema','Loop',null,'0','1','false'};
        private String[] ForeignKeys_type_info = new String[]{'ForeignKeys','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'IsSuccessful','Tables','Data','Fields','InfoSchema','ForeignKeys'};
    }
    public class RetrieveTableChildren_element {
        public String objectName;
        private String[] objectName_type_info = new String[]{'objectName','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'objectName'};
    }
    public class RetrieveTablesResponse_element {
        public ExternalDataService.ExternalDataResult RetrieveTablesResult;
        private String[] RetrieveTablesResult_type_info = new String[]{'RetrieveTablesResult','Loop',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'Loop','true','false'};
        private String[] field_order_type_info = new String[]{'RetrieveTablesResult'};
    }
    public class ExternalDataServiceSoap {
        public String endpoint_x = 'http://ec2-54-210-61-140.compute-1.amazonaws.com/ExternalDataService.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'Loop', 'ExternalDataService'};
        public ExternalDataService.ExternalDataResult RetrieveTableChildren(String objectName) {
            ExternalDataService.RetrieveTableChildren_element request_x = new ExternalDataService.RetrieveTableChildren_element();
            request_x.objectName = objectName;
            ExternalDataService.RetrieveTableChildrenResponse_element response_x;
            Map<String, ExternalDataService.RetrieveTableChildrenResponse_element> response_map_x = new Map<String, ExternalDataService.RetrieveTableChildrenResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'Loop/RetrieveTableChildren',
              'Loop',
              'RetrieveTableChildren',
              'Loop',
              'RetrieveTableChildrenResponse',
              'ExternalDataService.RetrieveTableChildrenResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.RetrieveTableChildrenResult;
        }
        public ExternalDataService.ExternalDataResult RetrieveTableDetails(String objectName) {
            ExternalDataService.RetrieveTableDetails_element request_x = new ExternalDataService.RetrieveTableDetails_element();
            request_x.objectName = objectName;
            ExternalDataService.RetrieveTableDetailsResponse_element response_x;
            Map<String, ExternalDataService.RetrieveTableDetailsResponse_element> response_map_x = new Map<String, ExternalDataService.RetrieveTableDetailsResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'Loop/RetrieveTableDetails',
              'Loop',
              'RetrieveTableDetails',
              'Loop',
              'RetrieveTableDetailsResponse',
              'ExternalDataService.RetrieveTableDetailsResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.RetrieveTableDetailsResult;
        }
        public ExternalDataService.ExternalDataResult RetrieveTableData(String query) {
            ExternalDataService.RetrieveTableData_element request_x = new ExternalDataService.RetrieveTableData_element();
            request_x.query = query;
            ExternalDataService.RetrieveTableDataResponse_element response_x;
            Map<String, ExternalDataService.RetrieveTableDataResponse_element> response_map_x = new Map<String, ExternalDataService.RetrieveTableDataResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'Loop/RetrieveTableData',
              'Loop',
              'RetrieveTableData',
              'Loop',
              'RetrieveTableDataResponse',
              'ExternalDataService.RetrieveTableDataResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.RetrieveTableDataResult;
        }
        public ExternalDataService.ExternalDataResult RetrieveTables() {
            ExternalDataService.RetrieveTables_element request_x = new ExternalDataService.RetrieveTables_element();
            ExternalDataService.RetrieveTablesResponse_element response_x;
            Map<String, ExternalDataService.RetrieveTablesResponse_element> response_map_x = new Map<String, ExternalDataService.RetrieveTablesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'Loop/RetrieveTables',
              'Loop',
              'RetrieveTables',
              'Loop',
              'RetrieveTablesResponse',
              'ExternalDataService.RetrieveTablesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.RetrieveTablesResult;
        }
    }
}