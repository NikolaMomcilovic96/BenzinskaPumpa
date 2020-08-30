package servleti;

import java.util.ArrayList;
import binovi.Korisnik;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class proslediRadnike extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Korisnik> lista = new ArrayList<Korisnik>();

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);
            Statement stmt = con.createStatement();

            String upit = "SELECT * FROM korisnik WHERE tipKorisnika = 'Menadzer' OR tipKorisnika = 'Prodavac'";

            ResultSet rs = stmt.executeQuery(upit);

            while (rs.next()) {
                lista.add(new Korisnik(rs.getInt("idKorisnika"), rs.getString("ime"), rs.getString("prezime"), rs.getString("email"), rs.getString("korisnickoIme"), rs.getString("lozinka"), rs.getInt("telefon"), rs.getInt("poeni"), rs.getString("tipKorisnika"), rs.getInt("idPumpe")));
            }

            request.setAttribute("lista", lista);
            request.getRequestDispatcher("radnici.jsp").forward(request, response);

            rs.close();
            stmt.close();
            con.close();
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
            request.setAttribute("greska", e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
