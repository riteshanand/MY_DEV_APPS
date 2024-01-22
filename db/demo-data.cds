namespace ibmcapapp.db;

using {ibmcapapp.reuse as spiderman} from './reuse';
using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';


context basic {
    //Grouping of tables for better reference
    entity Student : spiderman.address {
        key studentId : spiderman.Guid;
            class     : Association to one standard;
            nameFirst : String(255);
            nameLast  : String(255);
            age       : Int16;
            gender    : String(1);
    }

    entity standard {
        key id           : spiderman.Guid;
            className    : String(48);
            sections     : Int16;
            classTeacher : String(255);
    }

    entity books : cuid, managed {
        bookName :localized String(48);
        author   : String(255);

    }
}
