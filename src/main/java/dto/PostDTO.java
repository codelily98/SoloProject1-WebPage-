package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter

public class PostDTO {
	private int no;
	private String userId;
	private String title;
	private String post_content;
	private String logtime; 
}
