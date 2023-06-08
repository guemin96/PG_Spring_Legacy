package com.bit.dto;

import java.sql.Timestamp;



public class CommentDTO {
    private int comment_Id;
    private String pd_id;
    private String user_id;
    private String content;
    private int level;
    private int rootCommentId;
    private int parentCommentid;

    private Timestamp createDate;
    private Timestamp updateDate;

    @Override
    public String toString() {
        return "CommentDTO{" +
                "comment_Id=" + comment_Id +
                ", pd_id='" + pd_id + '\'' +
                ", user_id='" + user_id + '\'' +
                ", content='" + content + '\'' +
                ", level=" + level +
                ", rootCommentId=" + rootCommentId +
                ", parentCommentid=" + parentCommentid +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                '}';
    }

    public int getComment_Id() {
        return comment_Id;
    }

    public void setComment_Id(int comment_Id) {
        this.comment_Id = comment_Id;
    }

    public String getPd_id() {
        return pd_id;
    }

    public void setPd_id(String pd_id) {
        this.pd_id = pd_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getRootCommentId() {
        return rootCommentId;
    }

    public void setRootCommentId(int rootCommentId) {
        this.rootCommentId = rootCommentId;
    }

    public int getParentCommentid() {
        return parentCommentid;
    }

    public void setParentCommentid(int parentCommentid) {
        this.parentCommentid = parentCommentid;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public CommentDTO(int comment_Id, String pd_id, String user_id, String content, int level, int rootCommentId, int parentCommentid, Timestamp createDate, Timestamp updateDate) {
        this.comment_Id = comment_Id;
        this.pd_id = pd_id;
        this.user_id = user_id;
        this.content = content;
        this.level = level;
        this.rootCommentId = rootCommentId;
        this.parentCommentid = parentCommentid;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public CommentDTO() {
    }
}
