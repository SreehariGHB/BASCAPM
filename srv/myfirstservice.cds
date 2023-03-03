using {anubhav.db.master,anubhav.db.transaction} from '../db/datamodel';


service say {

    function hello(msg:String) returns String;

    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
    @insertonly
    entity InsertEmployeeSrv as projection on master.employees;
    @updateonly
    entity UpdateEmployeeSrv as projection on master.employees;
    @deleteonly 
    entity DeleteEmployeeSrv as projection on master.employees;

}