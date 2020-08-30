package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class dodavanjeFirmi extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String naziv = request.getParameter("naziv");
        String adresa = request.getParameter("adresa");
        String pib = request.getParameter("pib");
        String lozinka = request.getParameter("lozinka");
        String potvrda = request.getParameter("potvrda");
        String sifra = request.getParameter("sifra");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";


        if (naziv != null && naziv.length() > 0
                && adresa != null && adresa.length() > 0
                && pib != null && pib.length() > 0
                && lozinka != null && lozinka.length() > 0
                && sifra != null && sifra.length() > 0) {
            if (lozinka.equals(potvrda)) {
                try {
                    int PIB = Integer.parseInt(pib);
                    int Sifra = Integer.parseInt(sifra);

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dbUrl, user, pass);

                    String upit = "INSERT INTO firma(naziv,adresa,PIB,lozinka,idRukovodioca) VALUES (?,?,?,?,?)";

                    PreparedStatement ps = con.prepareStatement(upit);
                    ps.setString(1, naziv);
                    ps.setString(2, adresa);
                    ps.setInt(3, PIB);
                    ps.setString(4, lozinka);
                    ps.setInt(5, Sifra);
                    
                    try{
                        ps.executeUpdate();
                        
                        request.setAttribute("poruka", "Uspesno ste registrovali firmu u sistem");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }catch(SQLException e){
                        request.setAttribute("msg", e.getMessage());
                        request.getRequestDispatcher("registracija.jsp").forward(request, response);
                    }
                } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
                    request.setAttribute("msg", e.getMessage());
                    request.getRequestDispatcher("registracija.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("poruka", "Lozinke se ne poklapaju");
                request.getRequestDispatcher("registracija.jsp").forward(request, response);
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
