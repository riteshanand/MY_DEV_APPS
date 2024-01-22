namespace ibmcapapp.srv;

using {anubhav.db.master as master} from '../db/datamodel';


service MyService {

    function helloWorld(name : String(10), spiderman : String(10)) returns String(25);
    function calArea(radius : Int16)                               returns Int16;
    //projection for custom logic
    entity ReadEmployeeSrv as projection on master.employees;

}
