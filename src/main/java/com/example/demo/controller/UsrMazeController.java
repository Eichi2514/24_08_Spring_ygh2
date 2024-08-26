package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Maze;

@Controller
public class UsrMazeController {
	int mapWidth = 150;
	int mapHeight = 50;

	int[][] map = new int[mapHeight][mapWidth];

	int xCood = 5;
	int yCood = 5;

	UsrMazeController() {
		for (int X = 0; X < mapHeight ; X++) {
			for (int Y = 0; Y < mapWidth; Y++) {
				if (X == 0 || X == mapHeight - 1 || Y == 0 || Y == mapWidth - 1)
					map[X][Y] = 1;
			}
		}
		for (int x = xCood; x <= xCood + 9; x++) {
			for (int y = yCood; y <= yCood + 9; y++) {
				map[x][y] = 2;
			}
		}
		
		for (int x = 20; x <= 20 + 9; x++) {
			for (int y = 20; y <= 20 + 9; y++) {
				map[x][y] = 3;
			}
		}

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
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 0;
				}
			}
			xCood--;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 2;
				}
			}
		} else {
			return "Lost";
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyDown")
	@ResponseBody
	public String keyDown() {

		if (map[xCood + 10][yCood] == 0 && map[xCood + 10][yCood + 1] == 0 && map[xCood + 10][yCood + 2] == 0
				&& map[xCood + 10][yCood + 3] == 0 && map[xCood + 10][yCood + 4] == 0 && map[xCood + 10][yCood + 5] == 0
				&& map[xCood + 10][yCood + 6] == 0 && map[xCood + 10][yCood + 7] == 0 && map[xCood + 10][yCood + 8] == 0
				&& map[xCood + 10][yCood + 9] == 0) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 0;
				}
			}
			xCood++;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 2;
				}
			}
		} else {
			return "Lost";
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
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 0;
				}
			}
			yCood--;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 2;
				}
			}
		} else {
			return "Lost";
		}
		return "success";
	}

	@RequestMapping("/usr/maze/keyRight")
	@ResponseBody
	public String keyRight(Model model) {

		if (map[xCood][yCood + 10] == 0 && map[xCood + 1][yCood + 10] == 0 && map[xCood + 2][yCood + 10] == 0
				&& map[xCood + 3][yCood + 10] == 0 && map[xCood + 4][yCood + 10] == 0 && map[xCood + 5][yCood + 10] == 0
				&& map[xCood + 6][yCood + 10] == 0 && map[xCood + 7][yCood + 10] == 0 && map[xCood + 8][yCood + 10] == 0
				&& map[xCood + 9][yCood + 10] == 0) {
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 0;
				}
			}
			yCood++;
			for (int x = xCood; x <= xCood + 9; x++) {
				for (int y = yCood; y <= yCood + 9; y++) {
					map[x][y] = 2;
				}
			}

		} else {
			return "Lost";
		}
		return "success";
	}
}