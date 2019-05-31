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
                width: 80%; 
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

            .edit-cell {
                color: green;
            }

            .remove-cell {
                color: darkred;
            }
        </style>
    </head>
    
    <body>
        <nav class="navbar navbar-dark sticky-top bg-dark">
            <a class="btn btn-primary" onclick="history.back()" style="color:white">Voltar</a>
            
            <a class="navbar-brand" href="/">
                <i class="fas fa-lg fa-home"></i>
                S.M.A.R.T. Home 2019<sup>®</sup>
            </a>
            <a class="btn btn-primary" href="google.com">Sair</a>
        </nav>
        <br>
        <br>
        <h1 class="display-1" style="text-align: center">Medidores cadastrados</h1>
        <br>
        <br>

        <div class="container">
            <form action="/mavenproject1/requestcontroller" method="post">
                <div class="row">
                    <h3 class="display-5">Adicionar medidor</h3>

                    <table class="table table-hover">
                        <thead> 
                        <tr>
                                <th>Serial #</th>
                                <th>Nome</th>                    
                                <th>Tabela</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" name="serialno_medidores"></td>
                                <td><input type="text" name="nome"></td>
                                <td><input type="text" name="tabela"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input class="btn btn-outline-primary" type="submit" name="botaoSubmit"
                    value="ENVIAR"/>
                </div>
                <br>
                <br>
                <div class="row">
                    <table class="table table-hover">
                        <thead> 
                            <tr>
                                <th>Serial #</th>
                                <th>Nome</th>                    
                                <th>Tabela</th>
                                <th>Salvar edições</th>
                                <th>Remover</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  
                                Class.forName("org.postgresql.Driver");
                                Connection con = DriverManager.getConnection(
                                        "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                                        "tempumidade",                                  //User
                                        "tempumidade"); 
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM public.medidores;");

                                int contador = 0;

                                while(rs.next()){ 
                            %>
                            <tr>
                                <td contenteditable='true' id="<%= contador %>_serial_editavel"><%= rs.getString(1) %></td>
                                <td contenteditable='true' id="<%= contador %>_nome_editavel"><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                                <td>
                                    <form action="/mavenproject1/requestcontroller" method="post">
                                        <input type="hidden" value="<%= rs.getString(1) %>" id="<%= contador %>_serial" name="serialno_medidores" />
                                        <input type="hidden" value="<%= rs.getString(2) %>" id="<%= contador %>_nome" name="nome" />
                                        <input type="hidden" value="<%= rs.getString(3) %>" id="<%= contador %>" name="tabela" />
                                        <input type="hidden" value="edit" name="operation" />
                                        <button class="btn btn-success fas fa-check-circle"></button>
                                        <script>
                                            document.getElementById("<%= contador %>_serial_editavel").addEventListener("change", function() {
                                                document.getElementById("<%= contador %>_serial").value = document.getElementById("<%= contador %>_serial_editavel");
                                            });
                                        </script>
                                        <script>
                                            document.getElementById("<%= contador %>_nome_editavel").addEventListener("change", function() {
                                                document.getElementById("<%= contador %>_nome").value = document.getElementById("<%= contador %>_nome_editavel");
                                            });
                                        </script>
                                    </form></td>
                                <td>
                                    <form action="/mavenproject1/requestcontroller" method="post">
                                        <input type="hidden" value="<%= rs.getString(3) %>" name="tabela" />
                                        <input type="hidden" value="delete" name="operation" />
                                        <button class="btn btn-danger fas fa-times-circle" ></button>
                                    </form></td>
                            </tr>
                            <% 
                                    contador++;
                                }
                                if (stmt != null) { stmt.close(); }
                            %>
                        </tbody>
                    </table>
                </div>
            </form>
                 </div>
            </div>

            </div>
        </div>

        

    </body>
</html>


