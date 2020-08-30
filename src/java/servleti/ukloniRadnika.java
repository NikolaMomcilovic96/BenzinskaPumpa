package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ukloniRadnika extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sifra = request.getParameter("sifra");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            int Sifra = Integer.parseInt(sifra);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);

            String upit = "DELETE FROM korisnik WHERE idKorisnika = '" + Sifra + "'";

            PreparedStatement ps = con.prepareStatement(upit);

            try {
                ps.executeUpdate();
            } catch (SQLException e) {
                request.setAttribute("greska", e.getMessage());
                request.getRequestDispatcher("radnici.jsp").forward(request, response);
            }

            ps.close();
            con.close();

            request.setAttribute("poruka", "Uspešno ste uklonili radnika");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
            request.setAttribute("greska", e.getMessage());
            request.getRequestDispatcher("radnici.jsp").forward(request, response);
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
