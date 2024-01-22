module.exports = (srv) => {
    // const { EmployeeSet } = srv.entities;
    srv.on('helloWorld', (req) => {
        return "Hello" + req.data.name + req.data.spiderman;
    });

    srv.on('calArea', (req) => {
        // return 3.14 * req.data.radius * req.data.radius;
        return 3.14 * Math.pow(req.data.radius, 2);
    });

    srv.on('READ', "ReadEmployeeSrv", async (req, res) => {
        //ex1..read custom data
        // return {
        //     "ID": "SPIDERMAN",
        //     "nameFirst": "SAANAND",
        //     "nameMiddle": null,
        //     "nameLast": "Spring",
        //     "nameInitials": null,
        //     "sex": "F",
        //     "language": "E"
        // }
        const { employees } = cds.entities("anubhav.db.master")
        const cdstx = await cds.tx(req);
        const results = await cdstx.run(SELECT.from(employees).limit(5).where({ salaryAmount: { '>=': 25000 } }).orderBy('nameFirst'));
        // const results = cdstx.run(SELECT.from(employees).limit(5));
        const myResult = [];
        // results.forEach(function (element) {
        //     myResult.push({ name: element.nameFirst + element.nameLast });
        // });
        for (let i = 0; i < results.length; i++) {
            const element = results[i];
            myResult.push({ nameFirst: element.nameFirst + element.nameLast });
        }
        return myResult;
        // return results;
    });
}