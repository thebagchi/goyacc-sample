package main

import (
	"archive/zip"
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"path/filepath"
	"runtime"
)

//go:generate go install golang.org/x/tools/cmd/goyacc
//go:generate go install google.golang.org/protobuf/cmd/protoc-gen-go

const (
	ProtocLinux   = "https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip"
	ProtocWindows = "https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-win64.zip"
	ProtocDarwin  = "https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-osx-x86_64.zip"
)

func Unzip(source, destination string) error {
	data, err := ioutil.ReadFile(source)
	if nil != err {
		return err
	}
	_ = os.Remove(destination)
	reader, err := zip.NewReader(bytes.NewReader(data), int64(len(data)))
	if nil != err {
		return err
	}
	for _, file := range reader.File {
		if file.FileInfo().IsDir() {
			continue
		}
		err := func() error {
			reader, err := file.Open()
			if err != nil {
				return err
			}
			defer reader.Close()
			path := filepath.Join(destination, file.Name)
			_ = os.Remove(path)
			err = os.MkdirAll(filepath.Dir(path), os.ModePerm)
			if err != nil {
				return err
			}
			writer, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, file.Mode())
			if err != nil {
				return err
			}
			defer writer.Close()
			_, err = io.Copy(writer, reader)
			if err != nil {
				return err
			}
			return nil
		}()
		if nil != err {
			return err
		}
	}
	return nil
}

func DownloadFile(url, path string) error {
	err := os.MkdirAll(filepath.Dir(path), os.ModePerm)
	if nil != err {
		return err
	}
	out, err := os.Create(path)
	if err != nil {
		return err
	}
	defer out.Close()
	response, err := http.Get(url)
	if err != nil {
		return err
	}
	defer response.Body.Close()
	_, err = io.Copy(out, response.Body)
	if err != nil {
		return err
	}
	return nil
}

func DownloadProtoc() error {
	dir, err := os.Getwd()
	if nil != err {
		return err
	}
	if runtime.GOOS == "windows" {
		if _, err := os.Stat(filepath.Join(dir, "tools", "protoc-3.17.3-win64.zip")); os.IsNotExist(err) {
			err = DownloadFile(ProtocLinux, filepath.Join(dir, "tools", "protoc-3.17.3-linux-x86_64.zip"))
			err = DownloadFile(ProtocDarwin, filepath.Join(dir, "tools", "protoc-3.17.3-osx-x86_64.zip"))
			err = DownloadFile(ProtocWindows, filepath.Join(dir, "tools", "protoc-3.17.3-win64.zip"))
			if nil != err {
				return err
			}
		}
		err = Unzip(
			filepath.Join(dir, "tools", "protoc-3.17.3-win64.zip"),
			filepath.Join(dir, "tools", "protoc"),
		)
		if nil != err {
			return err
		}
	}
	if runtime.GOOS == "linux" {
		if _, err := os.Stat(filepath.Join(dir, "tools", "protoc-3.17.3-linux-x86_64.zip")); os.IsNotExist(err) {
			err = DownloadFile(ProtocWindows, filepath.Join(dir, "tools", "protoc-3.17.3-win64.zip"))
			err = DownloadFile(ProtocDarwin, filepath.Join(dir, "tools", "protoc-3.17.3-osx-x86_64.zip"))
			err = DownloadFile(ProtocLinux, filepath.Join(dir, "tools", "protoc-3.17.3-linux-x86_64.zip"))
			if nil != err {
				return err
			}
		}
		err = Unzip(
			filepath.Join(dir, "tools", "protoc-3.17.3-linux-x86_64.zip"),
			filepath.Join(dir, "tools", "protoc"),
		)
		if nil != err {
			return err
		}
	}
	if runtime.GOOS == "linux" {
		if _, err := os.Stat(filepath.Join(dir, "tools", "protoc-3.17.3-osx-x86_64.zip")); os.IsNotExist(err) {
			err = DownloadFile(ProtocWindows, filepath.Join(dir, "tools", "protoc-3.17.3-win64.zip"))
			err = DownloadFile(ProtocLinux, filepath.Join(dir, "tools", "protoc-3.17.3-linux-x86_64.zip"))
			err = DownloadFile(ProtocDarwin, filepath.Join(dir, "tools", "protoc-3.17.3-osx-x86_64.zip"))
			if nil != err {
				return err
			}
		}
		err = Unzip(
			filepath.Join(dir, "tools", "protoc-3.17.3-osx-x86_64.zip"),
			filepath.Join(dir, "tools", "protoc"),
		)
		if nil != err {
			return err
		}
	}
	return nil
}

func main() {
	err := DownloadProtoc()
	if nil != err {
		fmt.Println("Failed downloading protoc binaries")
		fmt.Println("Error: ", err)
		return
	}
}
