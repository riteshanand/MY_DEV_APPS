namespace ibmcapapp.reuse;

type Guid : String(32);

aspect address {
    city    : String(32);
    country : String(42);
    region  : String(4);
}
