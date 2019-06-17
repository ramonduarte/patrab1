package mvc;

import java.sql.Statement;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// import javax.inject.Inject;
// import javax.mvc.annotation.Controller;
// import javax.ws.rs.GET;
// import javax.ws.rs.Path;





@WebServlet(name = "RequestController", urlPatterns = { "/mavenproject1/requestcontroller" })
// @Controller
public class RequestController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Long emMilissegundos(int dias){
        Long res = Long.valueOf(dias * 24 * 60 * 60 * 1000);
        return res;
    }

    public Timestamp subtrai(int dias, Timestamp t) {
        Long milissegundos = emMilissegundos(dias);
        return new Timestamp(t.getTime() - milissegundos);
    }
    

    // Este controlador pode chamar vários handlers (tratadores de páginas)
    // Todos os hamdlers implementam a mesma interface.
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        request.setCharacterEncoding("UTF8");
        response.setCharacterEncoding("UTF8");
        String method = request.getMethod().toLowerCase();

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tempumidade", // Database URL
                "tempumidade", // User
                "tempumidade");

        try {
            System.out.println(method);
            if (method == "post") {
                String serialno_medidores;
                String nome;
                String tabela;

                System.out.println("começando");

                try {
                    serialno_medidores = request.getParameter("serialno_medidores");
                    nome = request.getParameter("nome");
                    tabela = request.getParameter("tabela");
                } catch (Exception b) {
                    PrintWriter writer = response.getWriter();
                    Enumeration<String> enm = request.getParameterNames();
                    serialno_medidores = request.getParameter(enm.nextElement());
                    nome = request.getParameter(enm.nextElement());
                    tabela = request.getParameter(enm.nextElement());
                    while (enm.hasMoreElements())
                        // System.out.println(enm.nextElement());
                        System.out.println(request.getParameter(enm.nextElement()));
                    writer.close();
                }
                System.out.println("ok até aqui");

                if (tabela == null) {
                    tabela = "medidor001";
                }
                if (serialno_medidores == null) {
                    serialno_medidores = "4";
                }
                if (nome == null) {
                    nome = "novo_nome";
                }

                Statement stmt4 = con.createStatement();
                stmt4.executeQuery("CREATE TABLE public." + tabela + " (serialno integer NOT NULL,"
                        + "medidor text NOT NULL," + "temperatura text NOT NULL," + "umidade text NOT NULL,"
                        + "datahora timestamp with time zone NOT NULL," + "serial text NOT NULL);"
                        + "CREATE SEQUENCE public." + tabela + "_serialno_seq AS integer "
                        + "START WITH 1 INCREMENT BY 1 " + "NO MINVALUE NO MAXVALUE CACHE 1;" + "ALTER SEQUENCE public."
                        + tabela + "_serialno_seq OWNED BY public." + tabela + ".serialno;"
                        + "INSERT INTO public.medidores(" + "serialno_medidores,nome,tabela) " + "values("
                        + serialno_medidores + "," + nome + "," + tabela + ");");

                // tratador = (IFTratadorDePaginas) Class.forName(medidor).newInstance();

                // String nomeDaPaginaDeResposta = tratador.processar(request, response);
                // request.getRequestDispatcher(nomeDaPaginaDeResposta).forward(request,
                // response);
                request.getRequestDispatcher("/pagina2.jsp").forward(request, response);

                // }
                // String serialno = request.getParameter("serialno");

            } else {
                String medidor = request.getParameter("medidor");
                String periodo = request.getParameter("periodo");
                String[] s_datafinal = request.getParameter("datafinal").split("T");
                System.out.println(s_datafinal[0] + " " + s_datafinal[1] + ":00");
                Timestamp datafinal = Timestamp.valueOf(s_datafinal[0] + " " + s_datafinal[1] + ":00");
                Timestamp datainicial;
                System.out.println("switch block");

                switch (periodo) {
                    case "s":
                        datainicial = subtrai(7, datafinal);
                        break;
                    case "m":
                        datainicial = subtrai(30, datafinal);
                        break;
                    case "a":
                        datainicial = subtrai(365, datafinal);
                        break;
                    case "d":
                        datainicial = datafinal;
                        break;
                    default:
                        datainicial = subtrai(36500, datafinal);
                        break;
                }

                System.out.println("building query");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM public." + medidor
                                                 + " WHERE datahora BETWEEN "
                                                 + datainicial + " AND " + datafinal
                                                 + ";");
                // + " where "
                // + "VALUES(" + medidor + ","
                // + temperatura + "," + umidade + ","
                // + datahora + "," + serial + ");");

                // tratador = (IFTratadorDePaginas) Class.forName(medidor).newInstance();
                System.out.println("SELECT * FROM public." + medidor + ";");

                // String nomeDaPaginaDeResposta = tratador.processar(request, response);
                // request.getRequestDispatcher(nomeDaPaginaDeResposta).forward(request,
                // response);
                request.getRequestDispatcher("").forward(request, response);

            }

        } catch (Exception e) {
            request.setCharacterEncoding("UTF8");
            response.setCharacterEncoding("UTF8");
            String method2 = request.getMethod().toLowerCase();

            String serialno_medidores;
            String nome;
            String tabela;
            
            System.out.println(method2);
            System.out.println(method2.equals("post"));
            System.out.println("começando");

            if (request.getParameter("tabela") != null) {
                System.out.println("post confirmado");
                if (request.getParameter("operation").equalsIgnoreCase("delete")) {
                    tabela = request.getParameter("tabela");

                    Statement stmt4 = con.createStatement();
                    stmt4.executeUpdate("DELETE FROM public.medidores WHERE tabela = '" + tabela + "';");
                    request.getRequestDispatcher("/pagina2.jsp").forward(request, response);
                    System.out.println("operação de remoção");
    
                } else if (request.getParameter("operation").equalsIgnoreCase("edit")) {
                    serialno_medidores = request.getParameter("serialno_medidores");
                    nome = request.getParameter("nome");
                    tabela = request.getParameter("tabela");

                    Statement stmt4 = con.createStatement();
                    System.out.println("UPDATE public.medidores SET serialno_medidores = '"
                    + serialno_medidores + "', nome = '" + nome
                    + "' WHERE tabela = '" + tabela + "';");
                    stmt4.executeUpdate("UPDATE public.medidores SET serialno_medidores = '"
                                        + serialno_medidores + "', nome = '" + nome
                                        + "' WHERE tabela = '" + tabela + "';");
                    request.getRequestDispatcher("/pagina2.jsp").forward(request, response);
                    System.out.println("operação de edição");
                } else {
                    try {
                        serialno_medidores = request.getParameter("serialno_medidores");
                        nome = request.getParameter("nome");
                        tabela = request.getParameter("tabela");
                    } catch (Exception b) {
                        PrintWriter writer = response.getWriter();
                        Enumeration<String> enm = request.getParameterNames();
                        serialno_medidores = request.getParameter(enm.nextElement());
                        nome = request.getParameter(enm.nextElement());
                        tabela = request.getParameter(enm.nextElement());
                        while (enm.hasMoreElements())
                            // System.out.println(enm.nextElement());
                            System.out.println(request.getParameter(enm.nextElement()));
                        writer.close();
                    }
                    System.out.println("ok até aqui");
                    System.out.println(tabela);
    
                    // Class.forName("org.postgresql.Driver");
                    // Connection con = DriverManager.getConnection(
                    // "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                    // "tempumidade", //User
                    // "tempumidade");
    
                    Statement stmt4 = con.createStatement();
                    try {
                        stmt4.executeQuery("CREATE TABLE public." + tabela + " (serialno integer NOT NULL,"
                                + "medidor text NOT NULL," + "temperatura text NOT NULL," + "umidade text NOT NULL,"
                                + "datahora timestamp with time zone NOT NULL," + "serial text NOT NULL);"
                                + "CREATE SEQUENCE public." + tabela + "_serialno_seq AS integer " + "START WITH 1 INCREMENT BY 1 "
                                + "NO MINVALUE NO MAXVALUE CACHE 1;" + "ALTER SEQUENCE public." + tabela
                                + "_serialno_seq OWNED BY public." + tabela + ".serialno;" + "INSERT INTO public.medidores("
                                + "serialno_medidores,nome,tabela) " + "values(" + serialno_medidores + ",'" + nome + "','" + tabela
                                + "');");
                        
                    } catch (Exception f) {
                        request.getRequestDispatcher("/pagina2.jsp").forward(request, response);
                    }
    
                    request.setAttribute("EXCESSAO_CONTROLLER", e.toString());
                    request.getRequestDispatcher("/pagina2.jsp").forward(request, response);
                }
            } else {

                String medidor = request.getParameter("medidor");
                String periodo = request.getParameter("periodo");
                String r_datafinal = request.getParameter("datafinal");
                if (r_datafinal == null) {
                    r_datafinal = "2019-05-13T16:54:00.0";
                }
                String[] s_datafinal = r_datafinal.split("T");
                System.out.println(s_datafinal[0] + " " + s_datafinal[1] + ":00");
                Timestamp datafinal = Timestamp.valueOf(s_datafinal[0] + " " + s_datafinal[1] + ":00");
                Timestamp datainicial;
                System.out.println("switch block");

                switch (periodo) {
                    case "s":
                        datainicial = subtrai(7, datafinal);
                        break;
                    case "m":
                        datainicial = subtrai(30, datafinal);
                        break;
                    case "a":
                        datainicial = subtrai(365, datafinal);
                        break;
                    case "d":
                        datainicial = datafinal;
                        break;
                    default:
                        datainicial = subtrai(36500, datafinal);
                        break;
                }

                System.out.println("building query");
                
                Statement stmt = con.createStatement();
                System.out.println("SELECT * FROM public." + medidor
                + " WHERE datahora BETWEEN '"
                + datainicial + "00' AND '" + datafinal
                + "00';");

                ResultSet rs = stmt.executeQuery("SELECT * FROM public." + medidor
                                                 + " WHERE datahora BETWEEN '"
                                                 + datainicial + "00' AND '" + datafinal
                                                 + "00';");

                // tratador = (IFTratadorDePaginas) Class.forName(medidor).newInstance();
                System.out.println("SELECT * FROM public." + medidor + ";");

                // String nomeDaPaginaDeResposta = tratador.processar(request, response);
                // request.getRequestDispatcher(nomeDaPaginaDeResposta).forward(request,
                // response);
                request.getRequestDispatcher("").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
} 




// /*
//  * To change this license header, choose License Headers in Project Properties.
//  * To change this template file, choose Tools | Templates
//  * and open the template in the editor.
//  */

// import java.io.IOException;
// import java.io.PrintWriter;
// import javax.servlet.ServletException;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;

// /**
//  *
//  * @author root
//  */
// public class RequestController extends HttpServlet {

//     /**
//      * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//      * methods.
//      *
//      * @param request servlet request
//      * @param response servlet response
//      * @throws ServletException if a servlet-specific error occurs
//      * @throws IOException if an I/O error occurs
//      */
//     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {
//         response.setContentType("text/html;charset=UTF-8");
//         try (PrintWriter out = response.getWriter()) {
//             /* TODO output your page here. You may use following sample code. */
//             out.println("<!DOCTYPE html>");
//             out.println("<html>");
//             out.println("<head>");
//             out.println("<title>Servlet RequestController</title>");            
//             out.println("</head>");
//             out.println("<body>");
//             out.println("<h1>Servlet RequestController at " + request.getContextPath() + "</h1>");
//             out.println("</body>");
//             out.println("</html>");
//         }
//     }

//     // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//     /**
//      * Handles the HTTP <code>GET</code> method.
//      *
//      * @param request servlet request
//      * @param response servlet response
//      * @throws ServletException if a servlet-specific error occurs
//      * @throws IOException if an I/O error occurs
//      */
//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {
//         processRequest(request, response);
//     }

//     /**
//      * Handles the HTTP <code>POST</code> method.
//      *
//      * @param request servlet request
//      * @param response servlet response
//      * @throws ServletException if a servlet-specific error occurs
//      * @throws IOException if an I/O error occurs
//      */
//     @Override
//     protected void doPost(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {
//         processRequest(request, response);
//     }

//     /**
//      * Returns a short description of the servlet.
//      *
//      * @return a String containing servlet description
//      */
//     @Override
//     public String getServletInfo() {
//         return "Short description";
//     }// </editor-fold>

// }
