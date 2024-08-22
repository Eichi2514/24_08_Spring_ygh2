package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.vo.Maze;

@Controller
public class UsrMazeController {
	
	Maze maze;

	@RequestMapping("/usr/maze/map")
	public String showMap(Model model) {

		// 0 : 빈공간
		// 1 : 벽
		// 2 : 캐릭터

		int[][] map = new int[100][100];

		int xCood = 1;
		int yCood = 1;

		for (int X = 0; X < 100; X++) {
			for (int Y = 0; Y < 100; Y++) {

				if (X == 0 || X == 99 || Y == 0 || Y == 99)
					map[X][Y] = 1;
			}
		}

		map[5][5] = 2;

		model.addAttribute("map", map);
		model.addAttribute("xCood", xCood);
		model.addAttribute("yCood", yCood);

		return "/usr/maze/map";
	}

	@RequestMapping("/usr/maze/keyUp")
	public Maze keyUp(int[][] map, int xCood, int yCood) {

		if (map[xCood - 1][yCood] == 0 && map[xCood - 1][yCood + 1] == 0 && map[xCood - 1][yCood + 2] == 0
				&& map[xCood - 1][yCood + 3] == 0 && map[xCood - 1][yCood + 4] == 0 && map[xCood - 1][yCood + 5] == 0
				&& map[xCood - 1][yCood + 6] == 0 && map[xCood - 1][yCood + 7] == 0 && map[xCood - 1][yCood + 8] == 0
				&& map[xCood - 1][yCood + 9] == 0) {
			
			xCood--;
			map[xCood][yCood] = 1;
		}

		maze = new Maze(map, xCood, yCood);

		return maze;
	}
	
	@RequestMapping("/usr/maze/keyDown")
	public Maze keyDown(int[][] map, int xCood, int yCood) {

		if (map[xCood + 11][yCood] == 0 && map[xCood + 11][yCood + 1] == 0 && map[xCood + 11][yCood + 2] == 0
				&& map[xCood + 11][yCood + 3] == 0 && map[xCood + 11][yCood + 4] == 0 && map[xCood + 11][yCood + 5] == 0
				&& map[xCood + 11][yCood + 6] == 0 && map[xCood + 11][yCood + 7] == 0 && map[xCood + 11][yCood + 8] == 0
				&& map[xCood + 11][yCood + 9] == 0) {
			map[xCood][yCood] = 0;
			xCood++;
			map[xCood][yCood] = 1;
		}

		maze = new Maze(map, xCood, yCood);

		return maze;
	}
	
	@RequestMapping("/usr/maze/keyLeft")
	public Maze keyLeft(int[][] map, int xCood, int yCood) {

		if (map[xCood][yCood - 1] == 0 && map[xCood + 1][yCood - 1] == 0 && map[xCood + 2][yCood - 1] == 0
				&& map[xCood + 3][yCood - 1] == 0 && map[xCood + 4][yCood - 1] == 0 && map[xCood + 5][yCood - 1] == 0
				&& map[xCood + 6][yCood - 1] == 0 && map[xCood + 7][yCood - 1] == 0 && map[xCood + 8][yCood - 1] == 0
				&& map[xCood + 9][yCood - 1] == 0) {
			map[xCood][yCood] = 0;
			yCood--;
			map[xCood][yCood] = 1;
		}

		maze = new Maze(map, xCood, yCood);

		return maze;
	}
	
	@RequestMapping("/usr/maze/keyRight")
	public Maze keyRight(int[][] map, int xCood, int yCood) {

		if (map[xCood][yCood + 11] == 0 && map[xCood + 1][yCood + 11] == 0 && map[xCood + 2][yCood + 11] == 0
				&& map[xCood + 3][yCood + 11] == 0 && map[xCood + 4][yCood + 11] == 0 && map[xCood + 5][yCood + 11] == 0
				&& map[xCood + 6][yCood + 11] == 0 && map[xCood + 7][yCood + 11] == 0 && map[xCood + 8][yCood + 11] == 0
				&& map[xCood + 9][yCood + 11] == 0) {
			map[xCood][yCood] = 0;
			yCood--;
			map[xCood][yCood] = 1;

		}

		maze = new Maze(map, xCood, yCood);

		return maze;
	}
}