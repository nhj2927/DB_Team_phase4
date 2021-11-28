package Vo;

public class Paging {
    private int page = 1; //현재 페이지 (get)
    private int totalCount; //row 전체의 수 (get)
    private int beginPage;  //출력 시작
    private int endPage;    //출력 끝
    private int displayRow = 10;  //한 페이지에 몇 개의 로우
    private int displayPage =10;  //한 페이지에 몇 개의 페이지
    boolean prev; //prev 버튼이 보일건지 안보일건지
    boolean next; //next 버튼이 보일건지 안보일건지
    private int startNum;
    private int endNum;

    public int getStartNum() {
        return startNum = (page-1)*displayRow+1;
    }

    public int getEndNum() {
        return endNum = page*displayRow;
    }

    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        this.page = page;
    }
    public int getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        paging();
    }
    public int getDisplayRow() {
        return displayRow;
    }
    public void setDisplayRow(int displayRow) {
        this.displayRow = displayRow;
    }
    public int getDisplayPage() {
        return displayPage;
    }
    public void setDisplayPage(int displayPage) {
        this.displayPage = displayPage;
    }
    public int getBeginPage() {
        return beginPage;
    }
    public int getEndPage() {
        return endPage;
    }
    public boolean isPrev() {
        return prev;
    }
    public boolean isNext() {
        return next;
    }
    private void paging(){
        endPage = ((int)Math.ceil(page/(double)displayPage))*displayPage;
        beginPage = endPage - (displayPage - 1);

        int totalPage = (int)Math.ceil(totalCount/(double)displayRow);
        if(totalPage<endPage){
            endPage = totalPage;
            next = false;
        }else{
            next = true;
        }
        prev = (beginPage==1)?false:true;
    }

}
