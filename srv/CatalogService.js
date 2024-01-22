module.exports = cds.service.impl(async function () {

    const { EmployeeSet, POs } = this.entities;
    //define generic handler for validation
    this.before(['UPDATE', 'CREATE'], EmployeeSet, async (req, res) => {
        console.log("Aa gaya", req.data.salaryAmount);
        if (parseFloat(req.data.salaryAmount) >= 1000000) {
            req.error(500, "Enter a value less than a milliion for employees !");
        }
    });

    this.after(['UPDATE', 'CREATE'], EmployeeSet, async (req, res) => {
        console.log("Salary deke Aa gaya wife ko ", res.data.salaryAmount);

    });

    this.on('boost', async (req, res) => {
        try {
            const ID = req.params[0];
            console.log("Hey chaman, your PO with id " + req.params[0] + " will be boosted !");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=': 20000 }
            }).where(ID);
        } catch (error) {
            return "Error" + error.toString();
        }
    });

    this.on('largestOrder', async (req, res) => {
        try {
            const ID = req.params[0];
            const tx = cds.tx(req);
            //selection of one row from DB  by gross amt.
            const reply = await tx.read(POs).orderBy({
                // GROSS_AMOUNT: 'desc'
                GROSS_AMOUNT: 'asc'
            }).limit(1);

            return reply;
        } catch (error) {
            return "Error" + error.toString();
        }
    });

});