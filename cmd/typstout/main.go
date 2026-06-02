package main

import (
	_ "embed"
	"flag"
	"fmt"
	"io/fs"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

//go:embed template.typ
var template string

func main() {
	var target string
	flag.StringVar(&target, "target", "./", "target directory in which we need to convert typst files into svg")
	flag.Parse()

	targetFolder, err := filepath.Abs(target)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	err = filepath.WalkDir(targetFolder, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.IsDir() {
			containingFolder := filepath.Base(filepath.Dir(path))
			if (containingFolder == "assets" || containingFolder == "diagrams") && filepath.Ext(path) == ".typ" {
				fmt.Printf("Processing file: %s\n", path)
				wrappedPath := strings.Replace(path, ".typ", ".wrapped.typ", 1)
				wrappedContent := template + "#include \"" + filepath.Base(path) + "\""
				os.WriteFile(wrappedPath, []byte(wrappedContent), 0644)
				outputSvgPath := strings.Replace(path, ".typ", ".svg", 1)
				cmd := exec.Command("typst", "compile", wrappedPath, outputSvgPath)
				err := cmd.Run()
				if err != nil {
					fmt.Printf("Error processing file %s: %v\n", path, err)
				} else {
					fmt.Printf("Successfully converted %s to %s\n", path, outputSvgPath)
				}
				os.Remove(wrappedPath)

				// Here you can add the logic to convert the .typ file to .svg
				// For example, you could call an external command or use a library to perform the conversion
			}
		}
		return nil
	})
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
}
