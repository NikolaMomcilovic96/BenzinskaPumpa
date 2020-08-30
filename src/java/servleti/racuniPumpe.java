package servleti;

import binovi.Racun;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class racuniPumpe extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Racun> lista = new ArrayList<Racun>();

        String sifra = request.getParameter("sifra");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            int Sifra = Integer.parseInt(sifra);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);
            Statement stmt = con.createStatement();

            String upit = "SELECT * FROM racun WHERE idPumpe = '" + Sifra + "'";

            ResultSet rs = stmt.executeQuery(upit);

            while (rs.next()) {
                lista.add(new Racun(rs.getInt("idRacuna"), rs.getInt("idPumpe"), rs.getInt("idProdavca"), rs.getInt("idKorisnika"), rs.getInt("idNarudzbenice"), rs.getInt("kolicina"), rs.getString("gorivo"), rs.getInt("cena"), rs.getString("datum"), rs.getString("vreme")));
            }

            request.setAttribute("listaPumpe", lista);
            request.getRequestDispatcher("racuni.jsp").forward(request, response);

            rs.close();
            stmt.close();
            con.close();
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
            request.setAttribute("msg", e.getMessage());
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
