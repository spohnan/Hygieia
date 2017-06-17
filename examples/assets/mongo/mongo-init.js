use dashboard
db.createUser({
    user: "dashboarduser",
    pwd: "dbpassword",
    roles: [
        {role: "readWrite", db: "dashboard"}
    ]
});