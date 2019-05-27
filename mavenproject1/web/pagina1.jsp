<%@ page import = "java.io.*, java.util.*, java.sql.*, java.time.*"%>
<%@ page import = "javax.servlet.http.*, javax.servlet.*" %>
<%@ page import = "com.postgresql.jdbc.Driver.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">


        <title>S.M.A.R.T. Home 2019® - Home Automation for the Nation</title>
        
        <style>
            table {
                width: 100%; 
                border-collapse: collapse; 
            }
            /* tr:nth-of-type(odd) { background: #eee; } */
            th { 
                background: #333; 
                color: white; 
                font-weight: bold; 
            }
            td, th { 
                padding: 6px; 
                border: 1px solid #ccc; 
                text-align: left; 
            }
            
            @media only screen and (max-width: 760px),
            (min-device-width: 768px) and (max-device-width: 1024px)  {
                table, thead, tbody, th, td, tr { display: block; }

                thead tr { 
                        position: absolute;
                        top: -9999px;
                        left: -9999px;
                }

                tr { border: 1px solid #ccc; }

                td { 
                        border: none;
                        border-bottom: 1px solid #eee; 
                        position: relative;
                        padding-left: 50%; 
                }

                td:before { 
                        position: absolute;
                        top: 6px;
                        left: 6px;
                        width: 45%; 
                        padding-right: 10px; 
                        white-space: nowrap;
                }

                td:nth-of-type(1):before { content: "Serial #"; }
                td:nth-of-type(2):before { content: "Medidor"; }
                td:nth-of-type(3):before { content: "Temperatura"; }
                td:nth-of-type(4):before { content: "Umidade"; }
                td:nth-of-type(5):before { content: "Data & Hora"; }
                td:nth-of-type(6):before { content: "Serial"; }
        }

            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }
            
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }
            
            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }
            
            input:checked + .slider {
                background-color: #2196F3;
            }
            
            input:focus + .slider {
                box-shadow: 0 0 1px #2196F3;
            }
            
            input:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }
            
            .slider.round {
                border-radius: 34px;
            }
            
            .slider.round:before {
                border-radius: 50%;
            }
        </style>
    </head>
    
    <!-- ========================================= -->
    <!-- Exemplo feito SEM TAGS, só com scriplets. -->
    <!-- ========================================= -->
    
    <body>
        <nav class="navbar navbar-dark sticky-top bg-dark">
            <a class="button" href="pagina2.jsp">Cadastrar</a>
            
            <a class="navbar-brand" href="#">
                <i class="fas fa-lg fa-home"></i>
                S.M.A.R.T. Home 2019<sup>®</sup>
            </a>
            <a class="button" href="#">Sair</a>
        </nav>
        <br>
        <br>
        <h1 class="display-1">Medidores</h1>
        <br>
        <br>

        <div class="container">
            <form action="/mavenproject1/requestcontroller" method="get">
                <div class="row">
                    <div class="form-group col">
                        <!-- <label for="selectMedidor">Medidor</label> -->
                        <select class="custom-select" id="selectMedidor" name="medidor">
                            <option selected value="">Medidor</option>
                                <%  
                                    Class.forName("org.postgresql.Driver");
                                    Connection con = DriverManager.getConnection(
                                            "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                                            "tempumidade",                                  //User
                                            "tempumidade"); 
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM public.medidores;");

                                    while(rs.next()){ 
                                %>
                                <option value="<%= rs.getString(3) %>"><%= rs.getString("nome") %></option>
                                <% 
                                    }
                                    if (stmt != null) { stmt.close(); }
                                %>
                            <!-- TODO: insert some JSP here 2019-05-22 14:05:43 -->
                        </select>
                    </div>
                    <div class="form-group col">
                        <!-- <label for="selectMedidor">Período</label> -->
                        <select class="custom-select" id="selectPeriodo" name="periodo">
                            <option selected value="">Período</option>
                            <option value="d">Diário</option>
                            <option value="s">Semanal</option>
                            <option value="m">Mensal</option>
                            <option value="a">Anual</option>
                        </select>
                    </div>
                    <div class="form-group col">
                        <!-- <label for="start">Data final</label> -->

                        <input type="datetime-local" id="start" name="datafinal"
                            value="2018-07-22" class="custom-select"
                            min="2018-01-01" max="2018-12-31">
                    </div>
                    <div class="form-group col">
                        <label class="switch">
                            <input type="checkbox" name="tabela">
                            <span class="slider round"></span>
                        </label>Gráfico
                    </div>
                    <div class="form-group col">
                        <button type="submit" role="button" class="btn btn-secondary">LER</button>
                    </div>
                </div>
            </form>
            </div>
            <div class="row">
                <table class="table table-hover" style="margin:0 10% 0 10%;max-width:80%;">
                    <thead> 
                        <tr>
                            <th>Medidor</th>
                            <th>Temperatura</th>                    
                            <th>Umidade</th>
                            <th>Data & Hora</th>
                            <th>Serial</th>
                        </tr>
                    </thead>
                    <%  
                        Class.forName("org.postgresql.Driver");
                        Connection con3 = DriverManager.getConnection(
                                "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                                "tempumidade",                                  //User
                                "tempumidade"); 
                        Statement stmt3 = con3.createStatement();
                        String med = "medidor001";
                        if (request.getParameter("medidor") != null) {
                            med = request.getParameter("medidor");
                        }
                        System.out.println(request.getParameter("medidor"));
                        ResultSet rs3 = stmt3.executeQuery("SELECT * FROM public."
                        + med + ";");

                        while(rs3.next()){ 
                    %>
                    <tbody>
                        <tr>
                            <td><%= rs3.getString(2) %></td>
                            <td><%= rs3.getString(3) %></td>
                            <td><%= rs3.getString(4) %></td>
                            <td><%= rs3.getString(5) %></td>
                            <td><%= rs3.getString(6) %></td>
                        </tr>
                    </tbody>
                    <% 
                        }
                        if (stmt3 != null) { stmt3.close(); }
                    %>
                </table>
            </div>
            </div>


            
        </div>

        <div class="container invisible" style="margin-top:20px">
            <div class="row">
                <form method="POST" id="novo_medidor" action="/controller">

                    <h3 class="display-5">Adicionar medidor:</h3>

                    <table class="table table-hover">
                        <thead> 
                        <tr>
                                <th>Medidor</th>
                                <th>Temperatura</th>                    
                                <th>Umidade</th>
                                <th>Data & Hora</th>
                                <th>Serial</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" name="medidor"></td>
                                <td><input type="text" name="temperatura"></td>
                                <td><input type="text" name="umidade"></td>
                                <td><input type="text" name="datahora"></td>
                                <td><input type="text" name="serial"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input class="btn btn-outline-primary" type="submit" name="botaoSubmit"
                    value="ENVIAR"/>
                </form>
                <%
                PreparedStatement pstatement = null;
                int updateQuery = 0;

                String medidor = request.getParameter("medidor");
                String temperatura = request.getParameter("temperatura");
                String umidade = request.getParameter("umidade");
                String datahora = request.getParameter("datahora");
                String serial = request.getParameter("serial");

                if (medidor != null && temperatura != null && umidade != null
                && datahora != null && serial != null) {
                    if (medidor!= "" && temperatura != "" && umidade != ""
                    && datahora != "" && serial != "") {
                        try {
                            Class.forName("org.postgresql.Driver");
                            Connection con2 = DriverManager.getConnection(
                                    "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                                    "tempumidade",                                  //User
                                    "tempumidade"); 
                            Statement stmt2 = con2.createStatement();
                            String queryString = "INSERT INTO "
                                                + "medidor001(medidor,temperatura,umidade,datahoraserial)"
                                                + " values(?,?,?,?,?)";
                            pstatement = con2.prepareStatement(queryString);
                            pstatement.setString(1, medidor);
                            pstatement.setString(2, temperatura);
                            pstatement.setString(3, umidade);
                            pstatement.setString(4, datahora);
                            pstatement.setString(5, serial);
                            updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
                                <br>
                                <table style="background-color: #E3E4FA;" WIDTH="30%" border="1">
                                    <tr><th>Concluído</th></tr>
                                </table>

                        <%
                            }
                        } catch (Exception e) {
                            out.println("Unable to connect to batabase.");
                        } finally {
                            // close all the connections.
                            pstatement.close();
                        }
                    }
                }
                %>
            </div>
        </div>
    </body>
</html>
