package servleti;

import binovi.Korisnik;
import java.sql.*;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class logovanje extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String korisnickoIme = request.getParameter("korisnickoIme");
        String lozinka = request.getParameter("lozinka");

        HttpSession sesija = request.getSession();
        Korisnik k = new Korisnik();

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";
        
        String msg = "";

        if (korisnickoIme.isEmpty() || lozinka.isEmpty()) {
            request.setAttribute("msg", "Morate uneti oba polja.");
            request.getRequestDispatcher("prijava.jsp").forward(request, response);
        } else {
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(dbUrl, user, pass);
                Statement st = con.createStatement();
                String upit = "SELECT * FROM korisnik WHERE korisnickoIme = '" + korisnickoIme + "' AND lozinka = '" + lozinka + "'";
                ResultSet rs = st.executeQuery(upit);

                if (rs.next()) {
                    k.setIdKorisnika(rs.getInt("idKorisnika"));
                    k.setIme(rs.getString("ime"));
                    k.setPrezime(rs.getString("prezime"));
                    k.setEmail(rs.getString("email"));
                    k.setKorinickoIme(korisnickoIme);
                    k.setLozinka(lozinka);
                    k.setTelefon(rs.getInt("telefon"));
                    k.setTipKorisnika(rs.getString("tipKorisnika"));
                    k.setIdPumpe(rs.getInt("idPumpe"));

                    st.close();
                    con.close();

                    sesija.setAttribute("k", k);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    request.setAttribute("msg", "Neispravno korisničko ime ili lozinka");
                    st.close();
                    con.close();
                    request.getRequestDispatcher("prijava.jsp").forward(request, response);
                }

            } catch (ClassNotFoundException e) {

            } catch (SQLException se) {
                sesija.invalidate();
                msg = se.getMessage();
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        msg += e.getMessage();
                    }
                    request.setAttribute("msg", msg);
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
