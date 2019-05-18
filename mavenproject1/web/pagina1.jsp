<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medidores</title>
        
        <style>
            table { 
                width: 100%; 
                border-collapse: collapse; 
            }
            tr:nth-of-type(odd) { background: #eee; }
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
                td:nth-of-type(5):before { content: "Data/Hora"; }
                td:nth-of-type(6):before { content: "Serial"; }
        }
        </style>
    </head>
    
    <!-- ========================================= -->
    <!-- Exemplo feito SEM TAGS, só com scriplets. -->
    <!-- ========================================= -->
    
    <body>
        <center>
        <br>
        <br>
        <h1 style="font-size:48px;">Medidores</h1>
        <br>
        <br>
        <table>
            <thead>
                <tr>
                    <th>Serial #</th>
                    <th>Medidor</th>
                    <th>Temperatura</th>                    
                    <th>Umidade</th>
                    <th>Data/Hora</th>
                    <th>Serial</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>James</td>
                    <td>Matman</td>
                    <td>Chief Sandwich Eater</td>
                </tr>
                <tr>
                    <td>The</td>
                    <td>Tick</td>
                    <td>Crimefighter Sorta</td>
                </tr>
            </tbody>
        </table>
<!--        <form method="GET" action="controller">
            
            <input type="hidden"
                   name="nomeDoTratadorDePagina"
                   value="mvc.pagehandlers.Tratador_pagina1_jsp" />

            <h2>Valor em Reais (BRL):<br><br>
                <% 
                    String valor = (String)request.getAttribute("VALOR_EM_REAIS");
                    if(valor==null) valor = "";
                %>
                R$ <input type="text" size="30"
                          name="VALOR_EM_REAIS"
                          value="<%= valor %>"/>
            <input type="submit" name="botaoSubmit" value="ENVIAR"/>
            <br>
            <br>
            <br>
            <br>
            <br>
            <%
                String erro = (String)request.getAttribute("MENSAGEM_DE_ERRO");
                if(erro==null) erro = "";
            %>
            <font color="red"><%= erro %></font>
            <br>
            </h2>
        </form>-->
        </center>
    </body>
</html>
