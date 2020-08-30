package servleti;

import binovi.Gorivo;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class dodajCene extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pumpa = request.getParameter("pumpa");
        String cena95 = request.getParameter("cena95");
        String cena98 = request.getParameter("cena98");
        String cenaDizel = request.getParameter("cenaDizel");
        String cenaPlin = request.getParameter("cenaPlin");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            int Cena95 = Integer.parseInt(cena95);
            int Cena98 = Integer.parseInt(cena98);
            int CenaDizel = Integer.parseInt(cenaDizel);
            int CenaPlin = Integer.parseInt(cenaPlin);
            int Pumpa = Integer.parseInt(pumpa);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);

            String upit = "INSERT INTO gorivo (cena95,cena98,cenaDizel,cenaPlin,idPumpe) VALUES (?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(upit);
            ps.setInt(1, Cena95);
            ps.setInt(2, Cena98);
            ps.setInt(3, CenaDizel);
            ps.setInt(4, CenaPlin);
            ps.setInt(5, Pumpa);

            ps.executeUpdate();

            request.setAttribute("poruka", "Uspešno ste dodali cene goriva");
            request.getRequestDispatcher("index.jsp").forward(request, response);

            ps.close();
            con.close();

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
            request.setAttribute("poruka", e.getMessage());
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
