package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Maze;

@Controller
public class UsrMazeController {
	int mapWidth = 200;
	int mapHeight = 200;
	
	int[][] map = new int[mapHeight][mapWidth];

	int xCood = 5;
	int yCood = 5;
	
	UsrMazeController (){
		for (int X = 0; X < mapWidth; X++) {
			for (int Y = 0; Y < mapHeight; Y++) {

				if (X == 0 || X == mapWidth-1 || Y == 0 || Y == mapHeight-1)
					map[X][Y] = 1;
			}
		}

		map[5][5] = 2;
		
	}

	@RequestMapping("/usr/maze/map")
	public String showMap(Model model) {

		// 0 : 빈공간
		// 1 : 벽
		// 2 : 캐릭터

		model.addAttribute("map", map);
		model.addAttribute("mapWidth", mapWidth);
		model.addAttribute("mapHeight", mapHeight);

		return "/usr/maze/map";
	}

	@RequestMapping("/usr/maze/keyUp")
	@ResponseBody
	public String keyUp() {

		if (map[xCood - 1][yCood] == 0 && map[xCood - 1][yCood + 1] == 0 && map[xCood - 1][yCood + 2] == 0
				&& map[xCood - 1][yCood + 3] == 0 && map[xCood - 1][yCood + 4] == 0 && map[xCood - 1][yCood + 5] == 0
				&& map[xCood - 1][yCood + 6] == 0 && map[xCood - 1][yCood + 7] == 0 && map[xCood - 1][yCood + 8] == 0
				&& map[xCood - 1][yCood + 9] == 0) {
			map[xCood][yCood] = 0;
			xCood--;
			map[xCood][yCood] = 2;
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyDown")
	@ResponseBody
	public String keyDown() {

		if (map[xCood + 11][yCood] == 0 && map[xCood + 11][yCood + 1] == 0 && map[xCood + 11][yCood + 2] == 0
				&& map[xCood + 11][yCood + 3] == 0 && map[xCood + 11][yCood + 4] == 0 && map[xCood + 11][yCood + 5] == 0
				&& map[xCood + 11][yCood + 6] == 0 && map[xCood + 11][yCood + 7] == 0 && map[xCood + 11][yCood + 8] == 0
				&& map[xCood + 11][yCood + 9] == 0) {
			map[xCood][yCood] = 0;
			xCood++;
			map[xCood][yCood] = 2;
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyLeft")
	@ResponseBody
	public String keyLeft() {

		if (map[xCood][yCood - 1] == 0 && map[xCood + 1][yCood - 1] == 0 && map[xCood + 2][yCood - 1] == 0
				&& map[xCood + 3][yCood - 1] == 0 && map[xCood + 4][yCood - 1] == 0 && map[xCood + 5][yCood - 1] == 0
				&& map[xCood + 6][yCood - 1] == 0 && map[xCood + 7][yCood - 1] == 0 && map[xCood + 8][yCood - 1] == 0
				&& map[xCood + 9][yCood - 1] == 0) {
			map[xCood][yCood] = 0;
			yCood--;
			map[xCood][yCood] = 2;
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyRight")
	@ResponseBody
	public String keyRight(Model model) {

		if (map[xCood][yCood + 11] == 0 && map[xCood + 1][yCood + 11] == 0 && map[xCood + 2][yCood + 11] == 0
				&& map[xCood + 3][yCood + 11] == 0 && map[xCood + 4][yCood + 11] == 0 && map[xCood + 5][yCood + 11] == 0
				&& map[xCood + 6][yCood + 11] == 0 && map[xCood + 7][yCood + 11] == 0 && map[xCood + 8][yCood + 11] == 0
				&& map[xCood + 9][yCood + 11] == 0) {
			map[xCood][yCood] = 0;
			yCood++;
			map[xCood][yCood] = 2;

		}
		return "success";
	}
}