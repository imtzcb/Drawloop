global class ExternalData implements Loop.IApexDataSource {
    public Set<string> getGlobalDescribe() {
        
        ExternalDataService.ExternalDataServiceSoap service = new ExternalDataService.ExternalDataServiceSoap();
        ExternalDataService.ExternalDataResult externalDataResult = service.RetrieveTables();
        
        Set<string> externalObjects = new Set<string>();
        if(externalDataResult.IsSuccessful) {
            string serializedObjects = externalDataResult.Tables;
            List<List<string>> objects = (List<List<string>>)JSON.deserialize(serializedObjects, List<List<string>>.class);
            for (List<string> obj : objects) {
                string objectName = obj[0];
                System.debug('Object: ' + objectName);
                externalObjects.add(objectName);
            }
        }
        return externalObjects;
    }
    
    private String queryStart = 'SELECT * FROM ';

    public List<Loop.ExternalData.DataObject> describeObjects(List<string> objNames) {
        List<Loop.ExternalData.DataObject> output = new List<Loop.ExternalData.DataObject>();
        Set<string> allObjects = getGlobalDescribe();
        for (string objName : objNames) {
            List<Loop.ExternalData.FieldInfo> outputFields = new List<Loop.ExternalData.FieldInfo>();
            if (allObjects.contains(objName)) {
                ExternalDataService.ExternalDataServiceSoap service = new ExternalDataService.ExternalDataServiceSoap();
                ExternalDataService.ExternalDataResult externalDataResult = service.RetrieveTableDetails(objName);
                
                if(externalDataResult.IsSuccessful) {
                    string foreignKeys = externalDataResult.ForeignKeys;
                    List<List<string>> foreignKeyInfo = (List<List<string>>)JSON.deserialize(foreignKeys, List<List<string>>.class);
                    Map<string, string> foreignKeyMap = new Map<string, string>();
                    for (List<string> foreignKey: foreignKeyInfo) {
                        System.debug(objName + '.ForeignKey: ' + String.join(foreignKey, ', '));
                        foreignKeyMap.put(foreignKey[0], foreignKey[1]);
                        //Loop.externalData.FieldInfo outputInfo = new Loop.ExternalData.FieldInfo(foreignKey[0], Schema.DisplayType.REFERENCE);
                        //outputInfo.referenceTo = foreignKey[1];
                        //outputFields.add(outputInfo);
                    }
                    
                    string serializedInfoSchema = externalDataResult.InfoSchema;
                    List<List<string>> infoSchemas = (List<List<string>>)JSON.deserialize(serializedInfoSchema, List<List<string>>.class);
                    for (List<string> infoSchema: infoSchemas) {
                        System.debug(objName + '.InfoSchema: ' + String.join(infoSchema, ', '));
                        
                        Loop.ExternalData.FieldInfo outputInfo;
                        if (foreignKeyMap.containsKey(infoSchema[0])) {
                            outputInfo = new Loop.ExternalData.FieldInfo(infoSchema[0], Schema.DisplayType.REFERENCE);
                            outputInfo.referenceTo = foreignKeyMap.get(infoSchema[0]);
                        }
                        else {
                            outputInfo = new Loop.ExternalData.FieldInfo(infoSchema[0], GetDisplayType(infoSchema[1]));
                        }
                        outputFields.add(outputInfo);
                    }
                }
            }
            output.add(new Loop.ExternalData.DataObject(objName, outputFields));
        }
        return output;
    }
    
    public DisplayType GetDisplayType(string type) {
        type = type.toLowerCase();
        
        Map<string, Schema.DisplayType> displayTypeMap = new Map<string, Schema.DisplayType>{
            'int' => Schema.DisplayType.Integer,
            'anytype' => Schema.DisplayType.anytype,
            'id' => Schema.DisplayType.ID,
            'varchar' => Schema.DisplayType.String,
            'text' => Schema.DisplayType.String,
            'longtext' => Schema.DisplayType.String,
            'mediumtext' => Schema.DisplayType.String,
            'tinytext' => Schema.DisplayType.String,
            'char' => Schema.DisplayType.String
        };
        
        if (displayTypeMap.containsKey(type)) {
            return displayTypeMap.get(type);
        }
        else {
            System.debug('Error: DisplayType not included in map (' + type + ')');
            return Schema.DisplayType.anytype;
        }
    }
    
    public Set<string> getChildRelationships(string objectName) {
    
        ExternalDataService.ExternalDataServiceSoap service = new ExternalDataService.ExternalDataServiceSoap();
        ExternalDataService.ExternalDataResult externalDataResult = service.RetrieveTableChildren(objectName);
        
        Set<string> children = new Set<string>();
        
        if(externalDataResult.IsSuccessful) {
            string foreignKeys = externalDataResult.ForeignKeys;
            List<List<string>> foreignKeyInfo = (List<List<string>>)JSON.deserialize(foreignKeys, List<List<string>>.class);
            for (List<string> foreignKey: foreignKeyInfo) {
                System.debug(objectName + '.ForeignKey: ' + String.join(foreignKey, ', '));
                children.add(foreignKey[2]);
            }
        }
        return children;
    }
    
    public Loop.ExternalData.QueryResultSet query(Loop.ExternalData.QueryRequestInfo requestInfo) {
        Loop.ExternalData.QueryResultSet results = new Loop.ExternalData.QueryResultSet();
        if (string.valueOf(requestInfo.RecordId).startswith(Schema.sObjectType.Opportunity.keyprefix)) {
            Set<string> allObjects = getGlobalDescribe();
            for (string objectName : requestInfo.GetObjectNames()) {
                if (allObjects.contains(objectName)) {
                    ExternalDataService.ExternalDataServiceSoap service = new ExternalDataService.ExternalDataServiceSoap();
                    string query = queryStart + objectName;
                    ExternalDataService.ExternalDataResult externalDataResult = service.RetrieveTableData(query);
                    Loop.ExternalData.QueryResult queryResult;

                    if(externalDataResult.IsSuccessful) {
                        List<string> fields = (List<string>)JSON.deserialize(externalDataResult.Fields, List<string>.class);
                        queryResult = new Loop.ExternalData.QueryResult(objectName, fields);
                        
                        string data = externalDataResult.Data;
                        List<List<string>> rows = (List<List<string>>)JSON.deserialize(data, List<List<string>>.class);
                        for (List<string> row : rows) {
                            queryResult.rows.add(row);
                            System.debug(objectName + '.TableData: ' + String.join(row, ', '));
                        }
                    } else {
                        //this doesn't work well, do something else
                        queryResult = new Loop.ExternalData.QueryResult(objectName, new List<string> {'Error'});
                        queryResult.rows.add(new List<string> {'error'});
                    }
                    results.add(queryResult);
                }
            }
        }
        return results;
    }
}