package servleti;

import binovi.Gorivo;
import java.sql.*;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class proslediCene extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String sifra = request.getParameter("sifra");

        Gorivo g = new Gorivo();
        HttpSession sesija = request.getSession();

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            int Sifra = Integer.parseInt(sifra);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);
            Statement stmt = con.createStatement();

            String upit = "SELECT * FROM gorivo WHERE idPumpe = '" + Sifra + "'";

            ResultSet rs = stmt.executeQuery(upit);

            if (rs.next()) {
                g.setIdCena(rs.getInt("idCena"));
                g.setCena95(rs.getInt("cena95"));
                g.setCena98(rs.getInt("cena98"));
                g.setCenaDizel(rs.getInt("cenaDizel"));
                g.setCenaPlin(rs.getInt("cenaPlin"));
                g.setIdPumpe(Sifra);

                rs.close();
                stmt.close();
                con.close();

                sesija.setAttribute("goriva", g);
                request.getRequestDispatcher("ceneGoriva.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Greska");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
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
