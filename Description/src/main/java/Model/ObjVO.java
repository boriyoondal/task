package Model;

public class ObjVO {
   private String current_dt;
   private String object_id;
   private String drinking;
   private String feed;
   private String activity;
   
   public String getCurrent_dt() {
      return current_dt;
   }
   public void setCurrent_dt(String current_dt) {
      this.current_dt = current_dt;
   }
   public String getObject_id() {
      return object_id;
   }
   public void setObject_id(String object_id) {
      this.object_id = object_id;
   }
   public String getDrinking() {
      return drinking;
   }
   public void setDrinking(String drinking) {
      this.drinking = drinking;
   }
   public String getFeed() {
      return feed;
   }
   public void setFeed(String feed) {
      this.feed = feed;
   }
   public String getActivity() {
      return activity;
   }
   public void setActivity(String activity) {
      this.activity = activity;
   }
   public ObjVO(String current_dt, String drinking, String feed, String activity) {
      super();
      this.current_dt = current_dt;
      this.drinking = drinking;
      this.feed = feed;
      this.activity = activity;
   }
   public ObjVO(String object_id) {
      this.object_id = object_id;
   }

   public ObjVO() {
      
   }
}