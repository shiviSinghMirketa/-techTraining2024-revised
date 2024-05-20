public class QuerryWrapper {
    public String fieldName;
    public String operator;
    public Object conditionValue;
    public String datatype;
    
    public QuerryWrapper( String fieldName, String operator, Object conditionValue, String datatype) {
        
        this.fieldName = fieldName;
        this.operator = operator;
        this.conditionValue = conditionValue;
        this.datatype = datatype;
    }
}