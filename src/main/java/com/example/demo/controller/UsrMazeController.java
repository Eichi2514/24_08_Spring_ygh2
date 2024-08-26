package com.example.demo.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrMazeController {
	int mapHeight = 50;
	int mapWidth = 150;

	int[][] map = new int[mapHeight][mapWidth];

	int charac = 1; // 캐릭터
	int characXCood = 5; // 캐릭터 x축 좌표
	int characYCood = 5;  // 캐릭터 y축 좌표
	
	int road = 0; // 빈공간
	int wall = 9; // 벽
	
	int mob2 = 2; // 몬스터
	int mob2XCood = (int) (Math.random() * ((40-20)+1)) + 20; // 몬스터 x축 좌표
	int mob2YCood = (int) (Math.random() * ((140-20)+1)) + 20; // 몬스터 y축 좌표




	UsrMazeController() {
		for (int X = 0; X < mapHeight ; X++) {
			for (int Y = 0; Y < mapWidth; Y++) {
				if (X == 0 || X == mapHeight - 1 || Y == 0 || Y == mapWidth - 1)
					map[X][Y] = wall;
			}
		}
		for (int x = characXCood; x <= characXCood + 9; x++) {
			for (int y = characYCood; y <= characYCood + 9; y++) {
				map[x][y] = charac;
			}
		}
		
		for (int x = mob2XCood; x <= mob2XCood + 9; x++) {
			for (int y = mob2YCood; y <= mob2YCood + 9; y++) {
				map[x][y] = 2;
			}
		}

	}

	@RequestMapping("/usr/maze/map")
	public String showMap(Model model) {

		model.addAttribute("map", map);
		model.addAttribute("mapWidth", mapWidth);
		model.addAttribute("mapHeight", mapHeight);
		
		model.addAttribute("charac", charac);
		model.addAttribute("characXCood", characXCood);
		model.addAttribute("characYCood", characYCood);
		
		model.addAttribute("mob2", mob2);
		model.addAttribute("mob2XCood", mob2XCood);
		model.addAttribute("mob2YCood", mob2YCood);

		return "/usr/maze/map";
	}

	@RequestMapping("/usr/maze/keyUp")
	@ResponseBody
	public String keyUp(@RequestBody Map<String, String> requestBody) {
	    int something = Integer.parseInt(requestBody.get("something2"));
	    int xCood = Integer.parseInt(requestBody.get("xCood2"));
	    int yCood = Integer.parseInt(requestBody.get("yCood2"));

		if (map[xCood - 1][yCood] <= 1 && map[xCood - 1][yCood + 1] <= 1 && map[xCood - 1][yCood + 2] <= 1
				&& map[xCood - 1][yCood + 3] <= 1 && map[xCood - 1][yCood + 4] <= 1 && map[xCood - 1][yCood + 5] <= 1
				&& map[xCood - 1][yCood + 6] <= 1 && map[xCood - 1][yCood + 7] <= 1 && map[xCood - 1][yCood + 8] <= 1
				&& map[xCood - 1][yCood + 9] <= 1) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = road;
				}
			}
			xCood--;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = something;
				}
			}
			if(something == charac) {
				characXCood--;
			} else if(something == mob2) {
				mob2XCood--;
			}
		} else {
			return "Lost";
		}
		return "success";
	}

	private int parseInt(int something) {
		// TODO Auto-generated method stub
		return 0;
	}

	@RequestMapping("/usr/maze/keyDown")
	@ResponseBody
	public String keyDown(@RequestBody Map<String, String> requestBody) {
	    int something = Integer.parseInt(requestBody.get("something2"));
	    int xCood = Integer.parseInt(requestBody.get("xCood2"));
	    int yCood = Integer.parseInt(requestBody.get("yCood2"));

		if (map[xCood + 10][yCood] <= 1 && map[xCood + 10][yCood + 1] <= 1 && map[xCood + 10][yCood + 2] <= 1
				&& map[xCood + 10][yCood + 3] <= 1 && map[xCood + 10][yCood + 4] <= 1 && map[xCood + 10][yCood + 5] <= 1
				&& map[xCood + 10][yCood + 6] <= 1 && map[xCood + 10][yCood + 7] <= 1 && map[xCood + 10][yCood + 8] <= 1
				&& map[xCood + 10][yCood + 9] <= 1) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = road;
				}
			}
			xCood++;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = something;
				}
			}
			if(something == charac) {
				characXCood++;
			} else if(something == mob2) {
				mob2XCood++;
			}
		} else {
			return "Lost";
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyLeft")
	@ResponseBody
	public String keyLeft(@RequestBody Map<String, String> requestBody) {
	    int something = Integer.parseInt(requestBody.get("something2"));
	    int xCood = Integer.parseInt(requestBody.get("xCood2"));
	    int yCood = Integer.parseInt(requestBody.get("yCood2"));

		if (map[xCood][yCood - 1] <= 1 && map[xCood + 1][yCood - 1] <= 1 && map[xCood + 2][yCood - 1] <= 1
				&& map[xCood + 3][yCood - 1] <= 1 && map[xCood + 4][yCood - 1] <= 1 && map[xCood + 5][yCood - 1] <= 1
				&& map[xCood + 6][yCood - 1] <= 1 && map[xCood + 7][yCood - 1] <= 1 && map[xCood + 8][yCood - 1] <= 1
				&& map[xCood + 9][yCood - 1] <= 1) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = road;
				}
			}
			yCood--;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = something;
				}
			}
			if(something == charac) {
				characYCood--;
			} else if(something == mob2) {
				mob2YCood--;
			}
		} else {
			return "Lost";
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyRight")
	@ResponseBody
	public String keyRight(@RequestBody Map<String, String> requestBody) {
	    int something = Integer.parseInt(requestBody.get("something2"));
	    int xCood = Integer.parseInt(requestBody.get("xCood2"));
	    int yCood = Integer.parseInt(requestBody.get("yCood2"));

		if (map[xCood][yCood + 10] <= 1 && map[xCood + 1][yCood + 10] <= 1 && map[xCood + 2][yCood + 10] <= 1
				&& map[xCood + 3][yCood + 10] <= 1 && map[xCood + 4][yCood + 10] <= 1 && map[xCood + 5][yCood + 10] <= 1
				&& map[xCood + 6][yCood + 10] <= 1 && map[xCood + 7][yCood + 10] <= 1 && map[xCood + 8][yCood + 10] <= 1
				&& map[xCood + 9][yCood + 10] <= 1) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = road;
				}
			}
			yCood++;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = something;
				}
			}
			if(something == charac) {
				characYCood++;
			} else if(something == mob2) {
				mob2YCood++;
			}
		} else {
			return "Lost";
		}
		return "success";
	}
}