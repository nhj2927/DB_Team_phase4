package controller;

import dao.MemberDao;
import vo.Member;
import vo.Paging;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class MemberListController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        MemberDao dao = MemberDao.getInstance();
        int page = 1;
        if(req.getParameter("page")!=null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        Paging paging = new Paging();
        int count = dao.getAllCount();
        paging.setTotalCount(count);
        paging.setPage(page);


        ArrayList<Member> list = dao.selectAllMember(paging);
        req.setAttribute("reportList", list);
        req.setAttribute("paging", paging);
        req.setAttribute("totalcount", count);

        res.setContentType("text/html; charset=EUC-KR");
        req.setCharacterEncoding("EUC-KR");
        RequestDispatcher dispatcher = req.getRequestDispatcher("Admin_memberList.jsp");
        dispatcher.forward(req, res);
    }
}
