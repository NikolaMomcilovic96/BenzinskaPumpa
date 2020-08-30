package servleti;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class platiPoenima extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String narudzbenica = request.getParameter("narudzbenica");
        String kupac = request.getParameter("kupac");
        String datum = request.getParameter("datum");
        String vreme = request.getParameter("vreme");
        String pumpa = request.getParameter("pumpa");
        String prodavac = request.getParameter("prodavac");
        String gorivo = request.getParameter("gorivo");
        String kolicina = request.getParameter("kolicina");
        String cena = request.getParameter("cena");
        String poeni = request.getParameter("noviPoeni");

        String Gorivo = "";

        String dbUrl = "jdbc:mysql://localhost:3306/pumpa";
        String user = "root";
        String pass = "";

        try {
            if (gorivo.equals("1")) {
                Gorivo = "BMB 95";
            } else if (gorivo.equals("2")) {
                Gorivo = "BMB 98";
            } else if (gorivo.equals("3")) {
                Gorivo = "Dizel";
            } else if (gorivo.equals("4")) {
                Gorivo = "Plin";
            }
            int Kupac = Integer.parseInt(kupac);
            int Pumpa = Integer.parseInt(pumpa);
            int Prodavac = Integer.parseInt(prodavac);
            int Kolicina = Integer.parseInt(kolicina);
            int Cena = Integer.parseInt(cena);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);

            String upit = "INSERT INTO racun (idPumpe,idProdavca,idKorisnika,kolicina,gorivo,cena,datum,vreme) VALUES (?,?,?,?,?,?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(upit);
            ps.setInt(1, Pumpa);
            ps.setInt(2, Prodavac);
            ps.setInt(3, Kupac);
            ps.setInt(4, Kolicina);
            ps.setString(5, Gorivo);
            ps.setInt(6, Cena);
            ps.setString(7, datum);
            ps.setString(8, vreme);
            
            try{
                ps.executeUpdate();
            }catch(SQLException e){
                request.setAttribute("greska", e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
            request.setAttribute("poruka", "Uspešno ste naplatili račun");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            
            ps.close();
            con.close();
        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e) {
            request.setAttribute("greska", e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        
        try{
            int Poeni = Integer.parseInt(poeni);
            int Kupac = Integer.parseInt(kupac);
            
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, user, pass);
            
            String upit = "UPDATE korisnik SET poeni = ? WHERE idKorisnika = ?";
            
            PreparedStatement ps = con.prepareStatement(upit);
            ps.setInt(1, Poeni);
            ps.setInt(2, Kupac);
            
            try{
                ps.executeUpdate();
            }catch(SQLException e){
                request.setAttribute("greska", e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            ps.close();
            con.close();
        }catch(IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e){
            request.setAttribute("greska", e.getMessage());
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
