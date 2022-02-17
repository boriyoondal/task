package Model;

public class ObjVO {
	private String object_id;
	private String Drinking;
	private String feed;
	private String activity;

	public String getObject_id() {
		return object_id;
	}

	public String getDrinking() {
		return Drinking;
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

	public void setDrinking(String drinking) {
		Drinking = drinking;
	}

	public void setObject_id(String object_id) {
		this.object_id = object_id;
	}

	public ObjVO(String object_id) {
		super();
		this.object_id = object_id;
	}
	
	public ObjVO() {
		
	}

	public ObjVO(String object_id, String drinking, String feed, String activity) {
		super();
		this.object_id = object_id;
		Drinking = drinking;
		this.feed = feed;
		this.activity = activity;
	}

	public ObjVO(String drinking, String feed, String activity) {
		super();
		Drinking = drinking;
		this.feed = feed;
		this.activity = activity;
	}

	public ObjVO(String object_id, String drinking) {
		this.object_id = object_id;
		this.Drinking = drinking;
	}
	
}
