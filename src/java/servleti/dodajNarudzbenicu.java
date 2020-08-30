package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class dodajNarudzbenicu extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String naziv = request.getParameter("gorivo");
        String kolicina = request.getParameter("kolicina");
        String pumpa = request.getParameter("pumpa");
        String datum = request.getParameter("datum");
        String sifra = request.getParameter("sifra");
        
        String naplaceno = "ne";

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        if (naziv != null && naziv.length() > 0
                && kolicina != null && kolicina.length() > 0
                && pumpa != null && pumpa.length() > 0
                && datum != null && datum.length() > 0
                && sifra != null && sifra.length() > 0) {
            try {
                int Kolicina = Integer.parseInt(kolicina);
                int Sifra = Integer.parseInt(sifra);

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dbUrl, user, pass);

                String upit = "INSERT INTO narudzbenica(nazivGoriva,kolicina,idPumpe,datum,naplaceno,idFirme) VALUES (?,?,?,?,?,?)";

                PreparedStatement ps = con.prepareStatement(upit);
                ps.setString(1, naziv);
                ps.setInt(2, Kolicina);
                ps.setString(3, pumpa);
                ps.setString(4, datum);
                ps.setString(5, naplaceno);
                ps.setInt(6, Sifra);
                
                try{
                    ps.executeUpdate();
                }catch(SQLException e){
                    request.setAttribute("msg", e.getMessage());
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
                
                con.close();
                
                request.setAttribute("poruka", "Uspesno ste poslali narudžbenicu");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
                request.setAttribute("msg", e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
