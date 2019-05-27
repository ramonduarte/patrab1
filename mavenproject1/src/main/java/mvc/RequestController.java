package mvc;

import java.sql.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// import javax.inject.Inject;
// import javax.mvc.annotation.Controller;
// import javax.ws.rs.GET;
// import javax.ws.rs.Path;


@WebServlet(name = "RequestController", urlPatterns = {"/mavenproject1/requestcontroller"})
// @Controller
public class RequestController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Este controlador pode chamar vários handlers (tratadores de páginas)
    // Todos os hamdlers implementam a mesma interface.
    protected void processRequest(  HttpServletRequest request,
                                    HttpServletResponse response)
            throws ServletException, IOException {

        // TODO: differentiate between post and get 2019-05-25 19:34:06
        
        request.setCharacterEncoding("UTF8");
        response.setCharacterEncoding("UTF8");
        IFTratadorDePaginas tratador;
        String method = request.getMethod().toLowerCase();

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/tempumidade", //Database URL
                    "tempumidade",                                  //User
                    "tempumidade"); 
            System.out.println(method);
            if (method == "post") {
                //TODO: write on DB & return filled JSP 2019-05-25 22:34:25
                String serialno = "";
                String medidor = request.getParameter("medidor");
                String temperatura = request.getParameter("temperatura");
                String umidade = request.getParameter("umidade");
                String datahora = request.getParameter("datahora");
                String serial = request.getParameter("serial");
    
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("INSERT INTO public.medidor001"
                                                 + "(medidor,temperatura,umidade,"
                                                 + "datahora,serial) "
                                                 + "VALUES(" + medidor + ","
                                                 + temperatura + "," + umidade + ","
                                                 + datahora + "," + serial + ");");
                
                // tratador = (IFTratadorDePaginas) Class.forName(medidor).newInstance();
                
                // String nomeDaPaginaDeResposta = tratador.processar(request, response);
                // request.getRequestDispatcher(nomeDaPaginaDeResposta).forward(request, response);
                request.getRequestDispatcher("").forward(request, response);

            // }
            // String serialno = request.getParameter("serialno");
                
            } else {
                // TODO: fetch from DB & return filled JSP 2019-05-25 22:34:57
                String medidor = request.getParameter("medidor");
                String periodo = request.getParameter("periodo");
                String datafinal = request.getParameter("datafinal");

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM public." + medidor
                                                 + ";");
                                                //  + " where "
                                                //  + "VALUES(" + medidor + ","
                                                //  + temperatura + "," + umidade + ","
                                                //  + datahora + "," + serial + ");");
                
                // tratador = (IFTratadorDePaginas) Class.forName(medidor).newInstance();
                System.out.println("SELECT * FROM public." + medidor + ";");
                
                // String nomeDaPaginaDeResposta = tratador.processar(request, response);
                // request.getRequestDispatcher(nomeDaPaginaDeResposta).forward(request, response);
                request.getRequestDispatcher("").forward(request, response);
                
            }
        
        } catch (Exception e) {
            request.setAttribute("EXCESSAO_CONTROLLER", e.toString());
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
