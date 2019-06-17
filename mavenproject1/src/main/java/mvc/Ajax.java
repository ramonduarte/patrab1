/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// import org.json.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonWriter;

/**
 *
 * @author ramon
 */
public class Ajax extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */

    private static final long serialVersionUID = 1L;

    private Long emMilissegundos(int dias) {
        Long res = Long.valueOf(dias * 24 * 60 * 60 * 1000);
        return res;
    }

    public Timestamp subtrai(int dias, Timestamp t) {
        Long milissegundos = emMilissegundos(dias);
        return new Timestamp(t.getTime() - milissegundos);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF8");
        response.setCharacterEncoding("UTF8");
        String method = request.getMethod().toLowerCase();

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tempumidade", // Database URL
                "tempumidade", // User
                "tempumidade");

        // try (PrintWriter out = response.getWriter()) {
        try {
            if (method.equals("post")) {
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
                System.out.println("SELECT * FROM public." + medidor + " WHERE datahora BETWEEN '" + datainicial
                        + "00' AND '" + datafinal + "00';");

                ResultSet rs = stmt.executeQuery("SELECT * FROM public." + medidor + " WHERE datahora BETWEEN '"
                        + datainicial + "00' AND '" + datafinal + "00';");
                System.out.println("SELECT * FROM public." + medidor + ";");

                // response.setContentType("application/json");
                // response.setCharacterEncoding("UTF-8");
                // response.getWriter().write(gson.toString());

                // request.getRequestDispatcher("").forward(request, response);

                response.setContentType("application/json; charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                ResultSetMetaData rsmd = rs.getMetaData();
                System.out.println(rsmd.getColumnLabel(1).toString());
                System.out.println(rsmd.getColumnCount());
                JsonWriter writer = new JsonWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));
                writer.beginArray();
                while(rs.next()) {
                    writer.beginObject();
                    for(int idx=1; idx<=rsmd.getColumnCount(); idx++) {
                        writer.name(rsmd.getColumnLabel(idx));
                        writer.value(rs.getString(idx));
                        System.out.println(rsmd.getColumnLabel(idx).toString() + " : " + rs.getString(idx).toString());
                    }
                    System.out.println("next");
                    writer.endObject();
                }
                writer.endArray(); 
                response.getOutputStream().flush();
                writer.close();
                System.out.println(writer.toString());
                // response.getWriter().write(writer.toString());
                System.out.println(response.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

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