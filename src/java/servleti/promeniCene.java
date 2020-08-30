package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class promeniCene extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cena95 = request.getParameter("95");
        String cena98 = request.getParameter("98");
        String dizel = request.getParameter("dizel");
        String plin = request.getParameter("plin");
        String sifra = request.getParameter("sifra");
        String pumpa = request.getParameter("pumpa");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        if (cena95 != null && cena95.length() > 0
                && cena98 != null && cena98.length() > 0
                && dizel != null && dizel.length() > 0
                && plin != null && plin.length() > 0
                && sifra != null && sifra.length() > 0
                && pumpa != null && pumpa.length() > 0) {
            try {
                int Cena95 = Integer.parseInt(cena95);
                int Cena98 = Integer.parseInt(cena98);
                int Dizel = Integer.parseInt(dizel);
                int Plin = Integer.parseInt(plin);
                int Sifra = Integer.parseInt(sifra);
                int Pumpa = Integer.parseInt(pumpa);

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dbUrl, user, pass);

                String upit = "UPDATE gorivo SET cena95 = ?, cena98 = ?, cenaDizel = ?, cenaPlin = ?, idPumpe = ? WHERE idCena = ?";

                PreparedStatement ps = con.prepareStatement(upit);
                ps.setInt(1, Cena95);
                ps.setInt(2, Cena98);
                ps.setInt(3, Dizel);
                ps.setInt(4, Plin);
                ps.setInt(5, Pumpa);
                ps.setInt(6, Sifra);
                
                ps.executeUpdate();
                
                request.setAttribute("poruka", "Uspešno ste izmenili cene goriva");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                
                ps.close();
                con.close();

            } catch (ClassNotFoundException | SQLException e) {
                request.setAttribute("greska", e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }else{
            request.setAttribute("msg", "Morate popuniti sva polja");
            request.getRequestDispatcher("izmenaCena.jsp").forward(request, response);
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
