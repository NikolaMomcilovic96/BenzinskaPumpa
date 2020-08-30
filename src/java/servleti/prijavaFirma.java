package servleti;

import binovi.Firma;
import binovi.Korisnik;
import java.sql.*;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class prijavaFirma extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String pib = request.getParameter("pib");
        String sifra = request.getParameter("sifra");
        String lozinka = request.getParameter("lozinka");

        HttpSession sesija = request.getSession();
        HttpSession ses = request.getSession();
        Firma f = new Firma();
        Korisnik k = new Korisnik();

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        String poruka = "";

        if (pib.isEmpty() || sifra.isEmpty() || lozinka.isEmpty()) {
            request.setAttribute("poruka", "Morate popuniti sva polja.");
            request.getRequestDispatcher("prijava.jsp").forward(request, response);
        } else {
            Connection con = null;

            try {
                int PIB = Integer.parseInt(pib);
                int Sifra = Integer.parseInt(sifra);

                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(dbUrl, user, pass);
                Statement stmt = con.createStatement();

                String upit = "SELECT * FROM korisnik WHERE idKorisnika = '" + Sifra + "'";

                ResultSet rs = stmt.executeQuery(upit);

                if (rs.next()) {

                    k.setIdKorisnika(Sifra);
                    k.setIme(rs.getString("ime"));
                    k.setPrezime(rs.getString("prezime"));
                    k.setEmail(rs.getString("email"));
                    k.setKorinickoIme(rs.getString("korisnickoIme"));
                    k.setLozinka(rs.getString("lozinka"));
                    k.setTelefon(rs.getInt("telefon"));
                    k.setTipKorisnika(rs.getString("tipKorisnika"));

                    sesija.setAttribute("k", k);
                    ses.setAttribute("f", f);
                    request.getRequestDispatcher("index.jsp").forward(request, response);

                    stmt.close();
                    con.close();

                } else {
                    request.setAttribute("poruka", "Neispravan PIB ili lozinka");
                    request.getRequestDispatcher("prijava.jsp").forward(request, response);

                    stmt.close();
                    con.close();
                }

            } catch (ClassNotFoundException e) {

            } catch (SQLException se) {
                sesija.invalidate();
                poruka = se.getMessage();
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        poruka += e.getMessage();
                    }
                    request.setAttribute("poruka", poruka);
                    request.getRequestDispatcher("prijava.jsp").forward(request, response);
                }
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
