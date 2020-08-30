package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class dodavanjeKorisnika extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String ime = request.getParameter("ime");
        String prezime = request.getParameter("prezime");
        String telefon = request.getParameter("telefon");
        String email = request.getParameter("email");
        String korisnickoIme = request.getParameter("korisnickoIme");
        String lozinka = request.getParameter("lozinka");
        String potvrda = request.getParameter("potvrda");
        String tip = request.getParameter("tip");

        String tipKorisnika1 = "Korisnik";
        String tipKorisnika2 = "Rukovodilac";

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);
            Statement st = con.createStatement();

            String upit = "SELECT korisnickoIme, lozinka FROM korisnik";

            ResultSet rs = st.executeQuery(upit);

            while (rs.next()) {
                if (korisnickoIme.equals(rs.getString("korisnickoIme"))) {
                    request.setAttribute("poruka", "Korisnicko ime je vec u upotrebi.");
                    request.getRequestDispatcher("registracija.jsp").forward(request, response);
                }
            }

            st.close();
            con.close();
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("registracija.jsp").forward(request, response);
        }

        if (korisnickoIme != null && korisnickoIme.length() > 0
                && lozinka != null && lozinka.length() > 0
                && potvrda != null && potvrda.length() > 0) {
            if (lozinka.equals(potvrda)) {
                if (tip == null) {
                    try {
                        int Telefon = Integer.parseInt(telefon);

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbUrl, user, pass);

                        String upit = "INSERT INTO korisnik(ime,prezime,telefon,email,korisnickoIme,lozinka,tipKorisnika) VALUES (?,?,?,?,?,?,?)";

                        PreparedStatement ps = con.prepareStatement(upit);
                        ps.setString(1, ime);
                        ps.setString(2, prezime);
                        ps.setInt(3, Telefon);
                        ps.setString(4, email);
                        ps.setString(5, korisnickoIme);
                        ps.setString(6, lozinka);
                        ps.setString(7, tipKorisnika1);

                        try {
                            ps.executeUpdate();
                        } catch (SQLException e) {
                            request.setAttribute("msg", e.getMessage());
                            request.getRequestDispatcher("registracija.jsp").forward(request, response);
                        }
                        request.setAttribute("msg", "Uspesno ste se registrovali. Unesite vaše podatke da bi ste se prijavili.");
                        request.getRequestDispatcher("prijava.jsp").forward(request, response);
                        ps.close();
                        con.close();

                    } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
                        request.setAttribute("msg", e.getMessage());
                        request.getRequestDispatcher("registracija.jsp");
                    }
                } else {
                    try {
                        int Telefon = Integer.parseInt(telefon);

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbUrl, user, pass);

                        String upit = "INSERT INTO korisnik(ime,prezime,telefon,email,korisnickoIme,lozinka,tipKorisnika) VALUES (?,?,?,?,?,?,?)";

                        PreparedStatement ps = con.prepareStatement(upit);
                        ps.setString(1, ime);
                        ps.setString(2, prezime);
                        ps.setInt(3, Telefon);
                        ps.setString(4, email);
                        ps.setString(5, korisnickoIme);
                        ps.setString(6, lozinka);
                        ps.setString(7, tipKorisnika2);

                        try {
                            ps.executeUpdate();
                        } catch (SQLException e) {
                            request.setAttribute("msg", e.getMessage());
                            request.getRequestDispatcher("registracija.jsp").forward(request, response);
                        }
                        request.setAttribute("msg", "Uspesno ste se registrovali. Unesite vaše podatke da bi ste se prijavili.");
                        request.getRequestDispatcher("prijava.jsp").forward(request, response);
                        ps.close();
                        con.close();

                    } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
                        request.setAttribute("msg", e.getMessage());
                        request.getRequestDispatcher("registracija.jsp");
                    }
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
