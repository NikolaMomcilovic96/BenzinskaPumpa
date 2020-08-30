package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class izmeniRadnika extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sifra = request.getParameter("idKorisnika");
        String ime = request.getParameter("ime");
        String prezime = request.getParameter("prezime");
        String email = request.getParameter("email");
        String korisnickoIme = request.getParameter("korisnickoIme");
        String lozinka = request.getParameter("lozinka");
        String telefon = request.getParameter("telefon");
        String tipKorisnika = request.getParameter("tipKorisnika");
        String pumpa = request.getParameter("pumpa");

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        if (ime != null && ime.length() > 0
                && prezime != null && prezime.length() > 0
                && tipKorisnika != null & tipKorisnika.length() > 0
                && pumpa != null && pumpa.length() > 0) {
            try {
                int Sifra = Integer.parseInt(sifra);
                int Telefon = Integer.parseInt(telefon);
                int Pumpa = Integer.parseInt(pumpa);
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dbUrl, user, pass);
                
                String upit = "UPDATE korisnik SET ime = ?, prezime = ?, email = ?, korisnickoIme = ?, lozinka = ?, telefon = ?, tipKorisnika = ?, idPumpe = ? WHERE idKorisnika = ?";
                
                PreparedStatement ps = con.prepareStatement(upit);
                ps.setString(1, ime);
                ps.setString(2, prezime);
                ps.setString(3, email);
                ps.setString(4, korisnickoIme);
                ps.setString(5, lozinka);
                ps.setInt(6, Telefon);
                ps.setString(7, tipKorisnika);
                ps.setInt(8, Pumpa);
                ps.setInt(9, Sifra);
                
                try{
                    ps.executeUpdate();
                }catch(SQLException e){
                    request.setAttribute("greska", e.getMessage());
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
                
                ps.close();
                con.close();
                
                request.setAttribute("poruka", "Uspešno ste izmenili radnika!");
                request.getRequestDispatcher("radnici.jsp").forward(request, response);
            } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
                request.setAttribute("greska", e.getMessage());
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
