package com.ereyes.academiaweb.config;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class JdbiConfig {

    private static final String URL = "jdbc:mariadb://localhost:3306/academia_web";
    private static final String USER = "academia_user";
    private static final String PASSWORD = "academia1234";

    private static final Jdbi jdbi = createJdbi();

    private JdbiConfig() {
    }

    private static Jdbi createJdbi() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("No se ha encontrado el driver de MariaDB", e);
        }

        return Jdbi.create(URL, USER, PASSWORD)
                .installPlugin(new SqlObjectPlugin());
    }

    public static Jdbi getJdbi() {
        return jdbi;
    }
}
