package servleti;

import java.sql.*;
import binovi.Gorivo;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class izmeniCene extends HttpServlet {

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
            Statement stmt = con.createStatement();

            String upit = "SELECT * FROM gorivo WHERE idCena = '" + Sifra + "'";

            ResultSet rs = stmt.executeQuery(upit);

            if (rs.next()) {
                Gorivo izmenaCena = new Gorivo(Sifra, rs.getInt("cena95"), rs.getInt("cena98"), rs.getInt("cenaDizel"), rs.getInt("cenaPlin"), rs.getInt("idPumpe"));

                request.setAttribute("gorivo", izmenaCena);
                request.getRequestDispatcher("izmenaCena.jsp").forward(request, response);
            }
            rs.close();
            stmt.close();
            con.close();

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
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
