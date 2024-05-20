public class Hello {
    public static void printData(){
        Set<String> nameList= new Set<String>();
        nameList.add('Shivi');
        nameList.add('Aakash');
        nameList.add('Rakhi');
        //System.debug(nameList); // set is ordered
        
        Map<Integer, String> nameMap = new Map<Integer,String>();
        nameMap.put(0, 'Aakash');
        nameMap.put(1, 'Abhijeet');
        nameMap.put(2, 'Shivi'); // map is also ordered, list is array
        //if(nameMap.containsKey(1)) {nameMap.put(1, 'Shiviiii');}
        
        System.debug(nameMap);
        for(Integer index: nameMap.keySet()){
            System.debug(nameMap.get(index));
        }
    }
}